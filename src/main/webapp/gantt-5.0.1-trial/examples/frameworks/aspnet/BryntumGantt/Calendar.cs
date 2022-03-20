
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------


namespace Bryntum.Gantt
{

using System;
    using System.Collections.Generic;
    
public partial class Calendar
{

    public Calendar()
    {

        this.ChildrenRaw = new HashSet<Calendar>();

        this.Resources = new HashSet<Resource>();

        this.Tasks = new HashSet<Task>();

        this.CalendarIntervals = new HashSet<CalendarInterval>();

    }


    public override int Id { get; set; }

    public override Nullable<int> parentIdRaw { get; set; }

    public string Name { get; set; }

    public Nullable<int> DaysPerMonth { get; set; }

    public Nullable<int> DaysPerWeek { get; set; }

    public Nullable<int> HoursPerDay { get; set; }



    public virtual ICollection<Calendar> ChildrenRaw { get; set; }

    public virtual Calendar Parent { get; set; }

    public virtual ICollection<Resource> Resources { get; set; }

    public virtual ICollection<Task> Tasks { get; set; }

    public virtual ICollection<CalendarInterval> CalendarIntervals { get; set; }

}

}