package bryntum.gantt.msprojectreader;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.json.JSONArray;
import org.json.JSONObject;

import net.sf.mpxj.DateRange;
import net.sf.mpxj.Day;
import net.sf.mpxj.DayType;
import net.sf.mpxj.ProjectCalendar;
import net.sf.mpxj.ProjectCalendarContainer;
import net.sf.mpxj.ProjectCalendarException;
import net.sf.mpxj.ProjectCalendarWeek;
import net.sf.mpxj.ProjectFile;

public class ExtCalendarsJSONBuilder implements JSONBuilder<JSONObject> {

    Properties properties;
    SimpleDateFormat dateFormat;
    SimpleDateFormat timeFormat;

    public ExtCalendarsJSONBuilder(Properties properties, SimpleDateFormat dateFormat, SimpleDateFormat timeFormat) {
        this.properties = properties;
        this.dateFormat = dateFormat;
        this.timeFormat = timeFormat;
    }

    private String getDateRangeString(DateRange range) {
        return timeFormat.format(range.getStart()) + "-" + timeFormat.format(range.getEnd());
    }

    private void fillWeekDaysJSON(JSONArray weekDaysJSON, ProjectCalendarWeek week) {
        DateRange weekRange = week.getDateRange();

        JSONObject dayJSON = new JSONObject();

        String overrideName = week.getName(), overrideStart = "", overrideEnd = "";

        if (weekRange != null) {
            overrideName = week.getName();
            overrideStart = dateFormat.format(weekRange.getStart());
            overrideEnd = dateFormat.format(weekRange.getEnd());

            dayJSON.put(properties.getProperty("calendarDay.NAME"), overrideName);
            dayJSON.put(properties.getProperty("calendarDay.START"), overrideStart);
            dayJSON.put(properties.getProperty("calendarDay.FINISH"), overrideEnd);
            dayJSON.put(properties.getProperty("calendarDay.TYPE"), "WEEKDAYOVERRIDE");
            dayJSON.put(properties.getProperty("calendarDay.DAY"), -1);

            weekDaysJSON.put(dayJSON);
        }

        // iterate over weekdays
        for (int i = 1; i <= 7; i++) {

            Day day = Day.getInstance(i);
            DayType dayType = week.getWorkingDay(day);

            if (dayType != DayType.DEFAULT) {

                dayJSON = new JSONObject();

                dayJSON.put(properties.getProperty("calendarDay.DAY"), i - 1);

                if (weekRange != null) {
                    dayJSON.put(properties.getProperty("calendarDay.NAME"), overrideName);
                    dayJSON.put(properties.getProperty("calendarDay.START"), overrideStart);
                    dayJSON.put(properties.getProperty("calendarDay.FINISH"), overrideEnd);
                    dayJSON.put(properties.getProperty("calendarDay.TYPE"), "WEEKDAYOVERRIDE");
                } else {
                    dayJSON.put(properties.getProperty("calendarDay.TYPE"), "WEEKDAY");
                }

                JSONArray dayAvailabilityList = new JSONArray();

                for (DateRange range : week.getHours(day)) {
                    dayAvailabilityList.put(getDateRangeString(range));
                }

                dayJSON.put(properties.getProperty("calendarDay.AVAILABILITY"), dayAvailabilityList);
                dayJSON.put(properties.getProperty("calendarDay.IS_WORKING_DAY"), dayType == DayType.WORKING);

                weekDaysJSON.put(dayJSON);
            }
        }
    }

    public JSONObject getCalendarJSON(ProjectCalendar calendar, Map<Integer, List<ProjectCalendar>> childrenById) {
        JSONObject calendarJSON = new JSONObject();

        calendarJSON.put(properties.getProperty("calendar.UNIQUE_ID"), calendar.getUniqueID());
        calendarJSON.put(properties.getProperty("calendar.NAME"), calendar.getName());

        ProjectCalendar parentCalendar = calendar.getParent();
        if (parentCalendar != null) {
            calendarJSON.put(properties.getProperty("calendar.PARENT_ID"), parentCalendar.getUniqueID());
        }

        // if we don't use a separate container for project fields
        if (!Boolean.parseBoolean(properties.getProperty("use.project.container"))) {
            // calculate unit conversion ratios
            calendarJSON.put(properties.getProperty("calendar.DAYS_PER_WEEK"), calendar.getMinutesPerWeek() / calendar.getMinutesPerDay());
            calendarJSON.put(properties.getProperty("calendar.DAYS_PER_MONTH"), calendar.getMinutesPerMonth() / calendar.getMinutesPerDay());
            calendarJSON.put(properties.getProperty("calendar.HOURS_PER_DAY"), calendar.getMinutesPerDay() / 60);
        }

        // let's try to find weekends

        // if Sunday or Saturday is a working day
        boolean weekendsAreWorkdays = calendar.isWorkingDay(Day.getInstance(1)) || calendar.isWorkingDay(Day.getInstance(7));

        if (!Boolean.parseBoolean(properties.getProperty("use.vanilla.calendars"))) {
            // if both Sunday & Saturday are non-working
            if (!calendar.isWorkingDay(Day.getInstance(1)) && !calendar.isWorkingDay(Day.getInstance(7))) {
                calendarJSON.put(properties.getProperty("calendar.WEEKEND_FIRST_DAY"), 6);
                calendarJSON.put(properties.getProperty("calendar.WEEKEND_SECOND_DAY"), 0);

                // ..otherwise let's get first two non-working days in a row
            } else {
                for (int i = 1; i < 7; i++) {
                    if (!calendar.isWorkingDay(Day.getInstance(i)) && !calendar.isWorkingDay(Day.getInstance(i + 1))) {
                        weekendsAreWorkdays = true;
                        calendarJSON.put(properties.getProperty("calendar.WEEKEND_FIRST_DAY"), i - 1);
                        calendarJSON.put(properties.getProperty("calendar.WEEKEND_SECOND_DAY"), i);
                        break;
                    }
                }
            }
        }

        if (!Boolean.parseBoolean(properties.getProperty("use.vanilla.calendars"))) {
            calendarJSON.put(properties.getProperty("calendar.WEEKENDS_ARE_WORKDAYS"), weekendsAreWorkdays);
        }

        // default availability

        JSONArray defaultAvailabilityList = new JSONArray();

        defaultAvailabilityList.put(getDateRangeString(ProjectCalendarWeek.DEFAULT_WORKING_MORNING));
        defaultAvailabilityList.put(getDateRangeString(ProjectCalendarWeek.DEFAULT_WORKING_AFTERNOON));

        calendarJSON.put(properties.getProperty("calendar.DEFAULT_AVAILABILITY"), defaultAvailabilityList);

        JSONArray daysJSON = new JSONArray();

        // collect default weekdays availability
        fillWeekDaysJSON(daysJSON, calendar);

        // collect week overrides
        for (ProjectCalendarWeek week : calendar.getWorkWeeks()) {
            fillWeekDaysJSON(daysJSON, week);
        }

        // TODO: day overrides are not mappable one-to-one since the Gantt uses another
        // data model for them
        // calendarJSON.put("exceptions", calendar.getCalendarExceptions().toString());
        for (ProjectCalendarException exception : calendar.getCalendarExceptions()) {
            JSONObject day = new JSONObject();

            day.put(properties.getProperty("calendarDay.TYPE"), "DAY");
            // TODO: this is incorrect of course generally speaking
            day.put(properties.getProperty("calendarDay.DATE"), dateFormat.format(exception.getFromDate()));
            day.put(properties.getProperty("calendarDay.NAME"), exception.getName());

            JSONArray availability = new JSONArray();

            for (DateRange range : exception) {
                availability.put(getDateRangeString(range));
            }

            day.put(properties.getProperty("calendarDay.AVAILABILITY"), availability);
            day.put(properties.getProperty("calendarDay.IS_WORKING_DAY"), exception.getWorking());

            daysJSON.put(day);
        }

        calendarJSON.put(properties.getProperty("calendar.DAYS"), daysJSON);

        // if the calendar has children
        if (childrenById.containsKey(calendar.getUniqueID())) {
            calendarJSON.put(properties.getProperty("calendar.LEAF"), false);

            // let's build JSON for the children
            JSONArray childrenJSON = new JSONArray();
            List<ProjectCalendar> children = childrenById.get(calendar.getUniqueID());
            for (ProjectCalendar child : children) {
                childrenJSON.put(getCalendarJSON(child, childrenById));
            }

            calendarJSON.put(properties.getProperty("calendar.CHILDREN"), childrenJSON);
            calendarJSON.put(properties.getProperty("calendar.EXPANDED"), true);
        } else {
            calendarJSON.put(properties.getProperty("calendar.LEAF"), true);
        }

        return calendarJSON;
    }

    @Override
    public JSONObject buildJSON(ProjectFile projectFile) {
        JSONObject calendarsJSON = new JSONObject();

        // if we don't use a separate container for project fields
        if (!Boolean.parseBoolean(properties.getProperty("use.project.container"))) {
            JSONObject calendarsMetaDataJSON = new JSONObject();
            calendarsMetaDataJSON.put("projectCalendar", projectFile.getDefaultCalendar().getUniqueID());
            calendarsJSON.put("metaData", calendarsMetaDataJSON);
        }

        ProjectCalendarContainer calendars = projectFile.getCalendars();

        Map<Integer, List<ProjectCalendar>> childrenById = new Hashtable<Integer, List<ProjectCalendar>>();
        ProjectCalendar parent = null;
        List<ProjectCalendar> children = null;
        // loop over calendars and collect children indexed by their parent ids
        // since calendars don't have ready "children" property
        for (ProjectCalendar calendar : calendars) {
            parent = calendar.getParent();

            if (parent != null) {
                if (!childrenById.containsKey(parent.getUniqueID())) {
                    children = new ArrayList<ProjectCalendar>();
                    childrenById.put(parent.getUniqueID(), children);
                } else {
                    children = childrenById.get(parent.getUniqueID());
                }
                children.add(calendar);
            }
        }

        // now let's loop and start building JSON from root nodes
        JSONArray calendarListJSON = new JSONArray();
        for (ProjectCalendar calendar : calendars) {
            // if it's a root node
            if (!calendar.isDerived()) {
                calendarListJSON.put(getCalendarJSON(calendar, childrenById));
            }
        }

        calendarsJSON.put(properties.getProperty("calendar.CHILDREN"), calendarListJSON);

        return calendarsJSON;
    }

}
