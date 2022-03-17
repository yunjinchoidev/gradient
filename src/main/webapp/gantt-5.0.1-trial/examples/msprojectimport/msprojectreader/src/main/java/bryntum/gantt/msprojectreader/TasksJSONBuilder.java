package bryntum.gantt.msprojectreader;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import org.json.JSONArray;
import org.json.JSONObject;

import net.sf.mpxj.ConstraintType;
import net.sf.mpxj.Duration;
import net.sf.mpxj.ProjectCalendar;
import net.sf.mpxj.ProjectFile;
import net.sf.mpxj.ProjectProperties;
import net.sf.mpxj.ScheduleFrom;
import net.sf.mpxj.Task;
import net.sf.mpxj.TaskMode;
import net.sf.mpxj.TaskType;
import net.sf.mpxj.TimeUnit;

/**
 * Class implementing extraction a MS Project file tasks data
 * into a JSONObject.
*/
public class TasksJSONBuilder implements JSONBuilder<JSONObject> {

    Properties properties;
    SimpleDateFormat dateFormat;
    boolean isMpx;

    // field names
    String idField;
    String nameField;
    String startField;
    String finishField;
    String durationField;
    String durationUnitField;
    String workField;
    String workUnitField;
    String calendarIdField;
    String percentCompleteField;
    String milestoneField;
    String rollupField;
    String modeField;
    String typeField;
    String constraintDateField;
    String constraintTypeField;
    String baselineStartField;
    String baselineFinishesField;
    String baselineDurationField;
    String childrenField;
    String expandedField;
    String leafField;

    String summaryTaskType;
    String dynamicAssignmentsType;

    public TasksJSONBuilder(Properties properties, SimpleDateFormat dateFormat, boolean isMpx) {
        this.properties = properties;
        this.dateFormat = dateFormat;
        this.isMpx      = isMpx;

        // load related properties
        loadProperties(properties);
    }

    public void loadProperties(Properties properties) {
        // load field names
        idField = properties.getProperty("task.UNIQUE_ID");
        nameField = properties.getProperty("task.NAME");
        startField = properties.getProperty("task.START");
        finishField = properties.getProperty("task.FINISH");
        durationField = properties.getProperty("task.DURATION");
        durationUnitField = properties.getProperty("task.DURATION_UNIT");
        workField = properties.getProperty("task.WORK");
        workUnitField = properties.getProperty("task.WORK_UNIT");
        calendarIdField = properties.getProperty("task.CALENDAR");
        percentCompleteField = properties.getProperty("task.PERCENT_COMPLETE");
        milestoneField = properties.getProperty("task.MILESTONE");
        rollupField = properties.getProperty("task.ROLLUP");
        modeField = properties.getProperty("task.MODE");
        typeField = properties.getProperty("task.TYPE");
        constraintDateField = properties.getProperty("task.CONSTRAINT_DATE");
        constraintTypeField = properties.getProperty("task.CONSTRAINT_TYPE");
        baselineStartField = properties.getProperty("task.BASELINE_START");
        baselineFinishesField = properties.getProperty("task.BASELINE_FINISHES");
        baselineDurationField = properties.getProperty("task.BASELINE_DURATION");
        childrenField = properties.getProperty("task.CHILDREN");
        expandedField = properties.getProperty("task.EXPANDED");
        leafField = properties.getProperty("task.LEAF");

        // we might force summary tasks to have a specific scheduling mode
        if (properties.getProperty("force.summaryTask.type") != null && !properties.getProperty("force.summaryTask.type").equals("")) {
            summaryTaskType = properties.getProperty("force.summaryTask.type");
        }

        // ExtGantt might use "DynamicAssignment" scheduling mode
        if (properties.getProperty("taskType.DYNAMIC_ASSIGNMENTS") != null && !properties.getProperty("taskType.DYNAMIC_ASSIGNMENTS").equals("")) {
            dynamicAssignmentsType = properties.getProperty("taskType.DYNAMIC_ASSIGNMENTS");
        }
    }

    private String getConstraintType(ConstraintType constraintType) {
        String result = null;

        if (constraintType != null) {
            result = properties.getProperty("constraintType." + constraintType);
        }

        return result;
    }

    String getUnitByTimeUnit(TimeUnit timeUnit) {
        String unitName = null;

        if (timeUnit != null) {
            unitName = timeUnit.getName();

            return properties.getProperty("timeUnit." + unitName, unitName);
        }

        return unitName;
    }

    private String getTaskType(Task task) {
        String result = properties.getProperty("taskType." + task.getType());

        // force parent tasks to have the scheduling mode defined w/ "force.summaryTask.type" option
        if (task.hasChildTasks() && summaryTaskType != null) {
            result = summaryTaskType;
        }
        else if (result == null) {
            // ExtGantt has not one-to-one mapping to MS Project task types
            if (dynamicAssignmentsType != null && task.getType() == TaskType.FIXED_DURATION && task.getEffortDriven()) {
                result = dynamicAssignmentsType;
            }
        }

        return result;
    }

    /**
     * Extracts the provided task data into JSON object.
     *
     * @param task Task to extract
     * @return JSON object keeping the extracted task data
     */
    public JSONObject getTaskJSON(Task task) {
        JSONObject object = new JSONObject();

        object.put(idField, task.getUniqueID());
        object.put(nameField, task.getName());

        if (task.getStart() != null) {
            object.put(startField, dateFormat.format(task.getStart()));
        }
        if (task.getFinish() != null) {
            object.put(finishField, dateFormat.format(task.getFinish()));
        }

        Duration duration = task.getDuration();
        if (duration != null) {
            object.put(durationField, duration != null ? duration.getDuration() : null);
            object.put(durationUnitField, getUnitByTimeUnit(duration.getUnits()));
        }

        Duration work = task.getWork();
        if (work != null) {
            object.put(workField, work != null ? work.getDuration() : null);
            object.put(workUnitField, getUnitByTimeUnit(work.getUnits()));
        }

        ProjectCalendar calendar = task.getCalendar();
        if (calendar != null) {
            object.put(calendarIdField, calendar.getUniqueID());
        }

        object.put(percentCompleteField, task.getPercentageComplete());
        object.put(milestoneField, task.getMilestone());
        object.put(rollupField, task.getRollup());
        object.put(modeField, task.getTaskMode() == TaskMode.MANUALLY_SCHEDULED);
        object.put(typeField, getTaskType(task));

        Date constraintDate = task.getConstraintDate();
        if (constraintDate != null) {
            object.put(constraintDateField, dateFormat.format(task.getConstraintDate()));
        }
        object.put(constraintTypeField, getConstraintType(task.getConstraintType()));

        if (task.getBaselineStart() != null) {
            object.put(baselineStartField, dateFormat.format(task.getBaselineStart()));
        }
        if (task.getBaselineFinish() != null) {
            object.put(baselineFinishesField, dateFormat.format(task.getBaselineFinish()));
        }
        // TODO: BaselineDuration is not supported by the Gantt Task model at the
        // moment, so this code doesn't work really
        if (task.getBaselineDuration() != null) {
            object.put(baselineDurationField, task.getBaselineDuration());
        }

        // retrieve the task children info
        JSONArray children = new JSONArray();

        for (Task child : task.getChildTasks()) {
            children.put(getTaskJSON(child));
        }

        if (children.length() > 0) {
            object.put(childrenField, children);
            object.put(expandedField, task.getExpanded());
            object.put(leafField, false);
        } else {
            object.put(leafField, true);
        }

        return object;
    }

    @Override
    public JSONObject buildJSON(ProjectFile projectFile) {
        JSONObject result = new JSONObject();

        ProjectProperties projectProperties = projectFile.getProjectProperties();

        JSONArray taskListJSON = new JSONArray();

        Task firstTask = projectFile.getChildTasks().get(0);

        // MPX file has different tasks structure comparing to MPP
        if (this.isMpx) {
            for (Task task : projectFile.getChildTasks()) {
                taskListJSON.put(getTaskJSON(task));
            }
        // If "Show Project Summary Task" option is enabled
        // we include firstTask into the response
        } else if (projectProperties.getShowProjectSummaryTask()) {
            taskListJSON.put(getTaskJSON(firstTask));
        } else  {
            for (Task task : firstTask.getChildTasks()) {
                taskListJSON.put(getTaskJSON(task));
            }
        }

        result.put(childrenField, taskListJSON);
        result.put(nameField, "Root Node");

        // if we don't use a separate container for project fields
        if (!Boolean.parseBoolean(properties.getProperty("use.project.container"))) {
            JSONObject tasksMetaDataJSON = new JSONObject();

            // depending on the project scheduling direction return either project start or
            // end date
            if (projectProperties.getScheduleFrom() == ScheduleFrom.START) {
                tasksMetaDataJSON.put("projectStartDate", dateFormat.format(projectProperties.getStartDate()));
            } else {
                tasksMetaDataJSON.put("projectEndDate", dateFormat.format(projectProperties.getFinishDate()));
                tasksMetaDataJSON.put("scheduleBackwards", true);
            }

            tasksMetaDataJSON.put("cascadeChanges", projectProperties.getHonorConstraints());
            result.put("metaData", tasksMetaDataJSON);
        }

        return result;
    }

}
