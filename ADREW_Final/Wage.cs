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
    
    public partial class Wage
    {
        public int WageID { get; set; }
        public int EmployeeID { get; set; }
        public bool isHourly { get; set; }
        public decimal Wage1 { get; set; }
        public bool isSalary { get; set; }
        public Nullable<decimal> Salary { get; set; }
        public bool isComm { get; set; }
        public Nullable<decimal> CommPerc { get; set; }
        public Nullable<int> CommBase { get; set; }
        public bool isBonus { get; set; }
        public Nullable<int> Bonus { get; set; }
    
        public virtual Employee Employee { get; set; }
    }
}