/***************************************************************************

Copyright (c) Microsoft Corporation. All rights reserved.
This code is licensed under the Visual Studio SDK license terms.
THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF
ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY
IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR
PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.

***************************************************************************/
using System;
using System.Runtime.InteropServices;

using Microsoft.VisualStudio.Package;
using VSLangProj;

namespace Microsoft.VisualStudio.Package.Automation
{
    [ComVisible(true)]
	public class OAReferenceBase<RefType> : Reference
		where RefType : ReferenceNode
	{
		private RefType referenceNode;
		public OAReferenceBase(RefType referenceNode)
		{
			this.referenceNode = referenceNode;
		}

		protected RefType BaseReferenceNode
		{
			get { return referenceNode; }
		}

		#region Reference Members
		public virtual int BuildNumber
		{
			get { return 0; }
		}

		public virtual References Collection
		{
			get
			{
				return BaseReferenceNode.Parent.Object as References;
			}
		}

		public virtual EnvDTE.Project ContainingProject
		{
			get
			{
				return BaseReferenceNode.ProjectMgr.GetAutomationObject() as EnvDTE.Project;
			}
		}

		public virtual bool CopyLocal
		{
			get
			{
				throw new Exception("The method or operation is not implemented.");
			}
			set
			{
				throw new Exception("The method or operation is not implemented.");
			}
		}

		public virtual string Culture
		{
			get { throw new Exception("The method or operation is not implemented."); }
		}

		public virtual EnvDTE.DTE DTE
		{
			get
			{
				return BaseReferenceNode.ProjectMgr.Site.GetService(typeof(EnvDTE.DTE)) as EnvDTE.DTE;
			}
		}

		public virtual string Description
		{
			get
			{
				return this.Name;
			}
		}

		public virtual string ExtenderCATID
		{
			get { throw new Exception("The method or operation is not implemented."); }
		}

		public virtual object ExtenderNames
		{
			get { throw new Exception("The method or operation is not implemented."); }
		}

		public virtual string Identity
		{
			get { throw new Exception("The method or operation is not implemented."); }
		}

		public virtual int MajorVersion
		{
			get { return 0; }
		}

		public virtual int MinorVersion
		{
			get { return 0; }
		}

		public virtual string Name
		{
			get { throw new Exception("The method or operation is not implemented."); }
		}

		public virtual string Path
		{
			get
			{
				return BaseReferenceNode.Url;
			}
		}

		public virtual string PublicKeyToken
		{
			get { throw new Exception("The method or operation is not implemented."); }
		}

		public virtual void Remove()
		{
			BaseReferenceNode.Remove(false);
		}

		public virtual int RevisionNumber
		{
			get { return 0; }
		}

		public virtual EnvDTE.Project SourceProject
		{
			get { return null; }
		}

		public virtual bool StrongName
		{
			get { return false; }
		}

		public virtual prjReferenceType Type
		{
			get { throw new Exception("The method or operation is not implemented."); }
		}

		public virtual string Version
		{
			get { return new Version().ToString(); }
		}

		public virtual object get_Extender(string ExtenderName)
		{
			throw new Exception("The method or operation is not implemented.");
		}
		#endregion
	}
}
