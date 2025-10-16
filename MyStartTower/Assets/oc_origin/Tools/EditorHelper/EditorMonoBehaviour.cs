#if UNITY_EDITOR
using UnityEngine;
using System;
using UnityEditor; 
namespace SLMEditor
{
    [ExecuteAlways]
    public class EditorMonoBehaviour : MonoBehaviour
    {
        private void OnEnable()
        {
            SceneView.duringSceneGui += OnSceneGUI;
        }

        private void OnDisable()
        {
            SceneView.duringSceneGui -= OnSceneGUI;
        }

        protected virtual void Update()
        {
            
        }

        protected virtual void OnSceneGUI(SceneView sceneView)
        {
            
        }

        internal class SceneDrawer:IDisposable
        {
            private SceneView sceneView;

            public SceneDrawer(SceneView view)
            {
                sceneView = view;
                Handles.BeginGUI();
            }


            public void Dispose()
            {
                Handles.EndGUI();
                sceneView.Repaint();
                sceneView = null;
            }
        }
    }
}
#endif