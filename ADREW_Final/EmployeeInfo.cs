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
    
    public partial class EmployeeInfo
    {
        public int EInfoID { get; set; }
        public int EmployeeID { get; set; }
        public Nullable<System.DateTime> DOB { get; set; }
        public string EEmail { get; set; }
        public string EAddress { get; set; }
        public string ECity { get; set; }
        public string Zip { get; set; }
        public string EState { get; set; }
        public string EPhone { get; set; }
    
        public virtual Employee Employee { get; set; }
    }
}
