using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace ADREW_Final.Models
{
    class ModelBase : INotifyPropertyChanged, IChangeTracking, IRevertibleChangeTracking
    {
        //Events
        public event PropertyChangedEventHandler PropertyChanged;

        //Boolean Values for Tracking Edits
        #region Tracking Booleans
        protected bool _IsNew;
        protected bool _IsDeleted;

        public bool IsNew
        {
            get { return _IsNew; }
            protected set
            {
                if (_IsNew != value)
                {
                    _IsNew = value;
                    PropertyChanged(this, new PropertyChangedEventArgs("IsNew"));
                }
            }
        }

        public bool IsDeleted
        {
            get { return _IsDeleted; }
            protected set
            {
                if (_IsDeleted != value)
                {
                    _IsDeleted = value;
                    PropertyChanged(this, new PropertyChangedEventArgs("IsDeleted"));
                }
            }
        }
        #endregion

        #region IChangedTracking Methods and Variables
        ///<summary>
        ///IChangedTracking Methods and Variables
        ///</summary>
        ///public bool IsChanged used to track if edits or changes
        ///have been made to the class.
        protected bool _IsChanged = false;
        public bool IsChanged
        {
            get { return _IsChanged; }
            protected set
            {
                if (_IsChanged != value)
                {
                    _IsChanged = value;
                    PropertyChanged(this, new PropertyChangedEventArgs("IsChanged"));
                }
            }
        }
        /// <summary>
        /// public void AcceptChanges(){} User control to accept the changes.
        /// </summary>
        public void AcceptChanges()
        {
            throw new NotImplementedException();
        }

        #endregion

        //IRevertibleChangeTracking Methods
        //Methods:
        //public void RejectChanges(){}.
        #region IRevertibleChangeTracking Methods
        public void RejectChanges()
        {
            throw new NotImplementedException();
        }
        #endregion
    }
}
