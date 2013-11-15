using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace ADREW_Final.Models
{
    class CDepartment : ModelBase
    {
        Department _DepartmentModel;

        public Department DepartmentModel
        {
            get { return _DepartmentModel; }
        }

        //Department Variables
        #region Department Variables
        private int _ID;
        private string _Name;

        public int ID {
            get { return _ID; }
        }

        public string Name {
            get { return _Name; }
            set { _Name = value; }
        }
        
        #endregion

        public CDepartment(Department D)
        {
            _DepartmentModel = D;
            _ID = D.DepartmentID;
            Name = D.Name;
        }
    }
}
