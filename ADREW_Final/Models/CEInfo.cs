using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ADREW_Final.Models
{
    class CEInfo : ModelBase
    {
        #region Wage Entity Model Variable
        private Wage _EmpWage;

        public Wage EmpWage
        {
            get { return _EmpWage; }
            set { _EmpWage = value; }
        }
        #endregion

        public string Age
        {
            get
            {
                return "4";
            }
        }
    }
}
