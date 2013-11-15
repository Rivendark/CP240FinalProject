using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace ADREW_Final.Models
{
    class CPosition : ModelBase
    {
        #region DepartmentPosition Entity Model
        private DepartmentPosition _DeptPosModel;

        public DepartmentPosition DeptPosModel
        {
            get { return _DeptPosModel; }
        }
        #endregion

        #region CPosition Variables
        /// <summary>
        /// Position Variables and Encapsulated Methods:
        /// PositionID(int)
        /// DepartmentID(int)
        /// Name(string)
        /// Desc(string)
        /// </summary>
        private int _PositionID;      
        private int _DepartmentID;
        private string _Name;
        private string _Desc;

        public int PositionID
        {
            get { return _PositionID; }
        }

        public int DepartmentID
        {
            get { return _DepartmentID; }
            private set { _DepartmentID = value; }
        }
        
        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public string Desc
        {
            get { return _Desc; }
            set { _Desc = value; }
        }
        #endregion

        #region Constructors
        public CPosition(DepartmentPosition DP)
        {
            _DeptPosModel = DP;
            _PositionID = DP.PositionID;
            DepartmentID = DP.DepartmentID;
            Name = DP.Name;
            Desc = DP.Descr;
        }

        public CPosition(int NewId)
        {
            _PositionID = NewId;
            _DeptPosModel = new DepartmentPosition();
        }
        #endregion

    }
}
