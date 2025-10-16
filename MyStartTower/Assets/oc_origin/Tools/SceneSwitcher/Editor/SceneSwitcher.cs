using UnityEditor;
using UnityEngine.SceneManagement;
using UnityEditor.SceneManagement;
using UnityEngine;

namespace UnityToolbarExtender.Helper
{
	static class ToolbarStyles
	{
		public static readonly GUIStyle commandButtonStyle;

		static ToolbarStyles()
		{
			commandButtonStyle = new GUIStyle("Command")
			{
				fontSize = 16,
				alignment = TextAnchor.MiddleCenter,
				imagePosition = ImagePosition.ImageAbove,
				fontStyle = FontStyle.Bold
			};
		}
	}

	[InitializeOnLoad]
	public class SceneSwitchLeftButton
	{
		static SceneSwitchLeftButton()
		{
			ToolbarExtender.LeftToolbarGUI.Add(OnToolbarGUI);
		}

		static void OnToolbarGUI()
		{
			GUILayout.FlexibleSpace();
			
			 

			if (GUILayout.Button(new GUIContent("UI", "UIEnvironments"), ToolbarStyles.commandButtonStyle))
			{
				SceneHelper.StartScene("UIEnvironments", false);
			}
			
			if (GUILayout.Button(new GUIContent("S", "SkillEditor"), ToolbarStyles.commandButtonStyle))
			{
				SceneHelper.StartScene("SkillScene", false);
			}
			
			if (GUILayout.Button(new GUIContent("T", "TimelineCreator"), ToolbarStyles.commandButtonStyle))
			{
				SceneHelper.StartScene("TimelineCreator", false);
			}
			
			if (GUILayout.Button(new GUIContent("G", "Start Game"), ToolbarStyles.commandButtonStyle))
			{
				SceneHelper.StartScene("GameLauncher");
			}
			
			/*if(GUILayout.Button(new GUIContent("1", "Start Scene 1"), ToolbarStyles.commandButtonStyle))
			{
				SceneHelper.StartScene("ToolbarExtenderExampleScene1");
			}

			if(GUILayout.Button(new GUIContent("2", "Start Scene 2"), ToolbarStyles.commandButtonStyle))
			{
				SceneHelper.StartScene("ToolbarExtenderExampleScene2");
			}*/
		}
	}

	public static class SceneHelper
	{
		static string sceneToOpen;
		private static bool _isPlay;

		public static void StartScene(string sceneName, bool isPlay = true)
		{
			if(EditorApplication.isPlaying)
			{
				EditorApplication.isPlaying = false;
			}

			_isPlay = isPlay;
			sceneToOpen = sceneName;
			EditorApplication.update += OnUpdate;
		}

		static void OnUpdate()
		{
			if (sceneToOpen == null ||
			    EditorApplication.isPlaying || EditorApplication.isPaused ||
			    EditorApplication.isCompiling || EditorApplication.isPlayingOrWillChangePlaymode)
			{
				return;
			}

			EditorApplication.update -= OnUpdate;

			if(EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
			{
				if(TrySwitchScene(sceneToOpen) && _isPlay)
					EditorApplication.isPlaying = true;
				
				// need to get scene via search because the path to the scene
				// file contains the package version so it'll change over time
				// string[] guids = AssetDatabase.FindAssets("t:scene " + sceneToOpen, null);
				// if (guids.Length == 0)
				// {
				// 	Debug.LogWarning("Couldn't find scene file");
				// }
				// else
				// {
				// 	string scenePath = AssetDatabase.GUIDToAssetPath(guids[0]);
				// 	EditorSceneManager.OpenScene(scenePath);
				// 	EditorApplication.isPlaying = true;
				// }
			}
			sceneToOpen = null;
		}


		public static bool TrySwitchScene(string sceneName)
		{
			var guids = AssetDatabase.FindAssets("t:scene " + sceneName, null);
			var result = guids.Length != 0;
			if (result)
			{
				var scenePath = AssetDatabase.GUIDToAssetPath(guids[0]);
				EditorSceneManager.OpenScene(scenePath);
			}
			return result;
		}
	}
}