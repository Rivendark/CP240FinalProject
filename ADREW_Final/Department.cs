//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ADREW_Final
{
    using System;
    using System.Collections.Generic;
    
    public partial class Department
    {
        public Department()
        {
            this.DepartmentPositions = new HashSet<DepartmentPosition>();
            this.Tasks = new HashSet<Task>();
        }
    
        public int DepartmentID { get; set; }
        public string Name { get; set; }
    
        public virtual ICollection<DepartmentPosition> DepartmentPositions { get; set; }
        public virtual ICollection<Task> Tasks { get; set; }
    }
}
