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
    
    public partial class Project
    {
        public Project()
        {
            this.ProjectPositions = new HashSet<ProjectPosition>();
            this.Tasks = new HashSet<Task>();
        }
    
        public int ProjectID { get; set; }
        public string Name { get; set; }
        public string Descr { get; set; }
    
        public virtual ICollection<ProjectPosition> ProjectPositions { get; set; }
        public virtual ICollection<Task> Tasks { get; set; }
    }
}
