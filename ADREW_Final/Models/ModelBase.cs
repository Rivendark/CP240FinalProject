using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace ADREW_Final.Models
{
    class ModelBase : INotifyPropertyChanged, IChangeTracking, IRevertibleChangeTracking, IDataErrorInfo
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
                    //PropertyChanged(this, new PropertyChangedEventArgs("IsChanged"));
                }
            }
        }
        /// <summary>
        /// public void AcceptChanges(){} User control to accept the changes.
        /// </summary>
        public virtual void AcceptChanges()
        {
            throw new NotImplementedException();
        }

        #endregion

        //IRevertibleChangeTracking Methods
        //Methods:
        //public void RejectChanges(){}.
        #region IRevertibleChangeTracking Methods
        public virtual void RejectChanges()
        {
            throw new NotImplementedException();
        }
        #endregion

        #region IDataErrorInfo
        private Dictionary<String, List<String>> Errors = new Dictionary<string, List<string>>();

        protected void AddError(string propertyName, string Error, bool isWarning)
        {
            if (!Errors.ContainsKey(propertyName))
                Errors[propertyName] = new List<string>();
            if (!Errors[propertyName].Contains(Error))
            {
                if (isWarning) Errors[propertyName].Add(Error);
                else Errors[propertyName].Insert(0, Error);
            }
        }

        protected void RemoveError(string propertyName, string Error)
        {
            if (Errors.ContainsKey(propertyName) && Errors[propertyName].Contains(Error))
            {
                Errors[propertyName].Remove(Error);
                if (Errors[propertyName].Count == 0) Errors.Remove(propertyName);
            }
        }
        public string Error
        {
            get { throw new NotImplementedException(); }
        }

        public string this[string propertyName]
        {
            get {
                return (!Errors.ContainsKey(propertyName) ? null : String.Join(Environment.NewLine, Errors[propertyName]));
            }
        }

        #endregion
    }
}
