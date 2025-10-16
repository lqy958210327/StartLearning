using System;
using SLMEditor;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;

public class MenuTools : MonoBehaviour
{
    private static readonly int BattleTimeScale = Shader.PropertyToID("_BattleTimeScale");

    [MenuItem("Tools/工程清理/清理Material中废弃属性")]
    public static void ClearMaterialUnusedProperties()
    {
        var matGuids = AssetDatabase.FindAssets("t:Material", new string[] {"Assets/slm_origin/HotUpdateResources/Materials"});

        for (var idx = 0; idx < matGuids.Length; ++idx)
        {
            var guid = matGuids[idx];
            EditorUtility.DisplayProgressBar(string.Format("批处理中...{0}/{1}", idx + 1, matGuids.Length),
                "清理Material废弃属性", (idx + 1.0f) / matGuids.Length);

            var mat = AssetDatabase.LoadAssetAtPath<Material>(AssetDatabase.GUIDToAssetPath(guid));
            var matInfo = new SerializedObject(mat);
            var propArr = matInfo.FindProperty("m_SavedProperties");
            propArr.Next(true);
            do
            {
                if (!propArr.isArray)
                {
                    continue;
                }

                for (int i = propArr.arraySize - 1; i >= 0; --i)
                {
                    var prop = propArr.GetArrayElementAtIndex(i);
                    if (!mat.HasProperty(prop.displayName))
                    {
                        propArr.DeleteArrayElementAtIndex(i);
                    }
                }
            } while (propArr.Next(false));

            matInfo.ApplyModifiedProperties();
        }

        AssetDatabase.SaveAssets();
        EditorUtility.ClearProgressBar();

        Debug.Log("clear all material's properties is done!");
    }

    [MenuItem("Tools/工程清理/清理Material中KeyWords")]
    public static void ClearMaterialKeyWords()
    {
        var matGuids = AssetDatabase.FindAssets("t:Material", new string[] {"Assets/slm_origin/HotUpdateResources/Materials"});
        AssetDatabase.StartAssetEditing();
        try
        {
            for (var idx = 0; idx < matGuids.Length; ++idx)
            {
                var guid = matGuids[idx];
                EditorUtility.DisplayProgressBar(string.Format("批处理中...{0}/{1}", idx + 1, matGuids.Length),
                    "清理Material keywords", (idx + 1.0f) / matGuids.Length);

                var mat = AssetDatabase.LoadAssetAtPath<Material>(AssetDatabase.GUIDToAssetPath(guid));
                var matInfo = new SerializedObject(mat);
                var propArr = matInfo.FindProperty("m_ShaderKeywords");
                if (propArr == null)
                    continue;
                propArr.stringValue = "";
                matInfo.ApplyModifiedProperties();
            }
        }
        catch (Exception e)
        {
            EditorUtility.ClearProgressBar();
            throw;
        }
        finally
        {
            AssetDatabase.SaveAssets();
            AssetDatabase.StopAssetEditing();
            AssetDatabase.Refresh();
            EditorUtility.ClearProgressBar();

            Debug.Log("clear all material's keywords is done!");
        }

        
    }

    
    [MenuItem("Tools/工程清理/清理粒子mesh")]
    public static void ClearPrefabs()
    {
        string[] allGuids = AssetDatabase.FindAssets("t:Prefab", new string[] { 
            "Assets/slm_origin/HotUpdateResources/Prefabs/AbilityEffect", 
            "Assets/slm_origin/HotUpdateResources/Prefabs/CharactersShowVFXs", 
            "Assets/slm_origin/HotUpdateResources/Prefabs/VFXs",
            "Assets/slm_origin/HotUpdateResources/Prefabs/UI/UIEff"
        });
        float percent = 1.0f / allGuids.Length;
        string prefabPath;

        GameObject curPrefab = null;
        ParticleSystemRenderer[] renders;
        try
        {
            AssetDatabase.StartAssetEditing();
            for (int i = 0; i < allGuids.Length; ++i)
            {
                EditorUtility.DisplayProgressBar("正在清理", "正在清理第" + (i + 1) + "个预制体", percent * i);
                prefabPath = AssetDatabase.GUIDToAssetPath(allGuids[i]);
                curPrefab = AssetDatabase.LoadAssetAtPath(prefabPath, typeof(GameObject)) as GameObject;

                if (curPrefab != null)
                {
                    renders = curPrefab.GetComponentsInChildren<ParticleSystemRenderer>(true);
                    for (int j = 0; j < renders.Length; ++j)
                    {
                        // 清理ParticleSystem的冗余Mesh引用
                        if (renders[j].renderMode != ParticleSystemRenderMode.Mesh)
                        {
                            renders[j].SetMeshes(new Mesh[]{});
                        }
                    }

                    EditorUtility.SetDirty(curPrefab);
                }
            }
        }
        catch (Exception e)
        {
            Debug.LogError(e);
        }
        finally
        {
            EditorUtility.ClearProgressBar();
            AssetDatabase.SaveAssets();
            AssetDatabase.StopAssetEditing();
            AssetDatabase.Refresh();
        }
    }

    [MenuItem("Tools/刷新AssetDatabase")]
    public static void DoRefreshAssetDatabase()
    {
        AssetDatabase.Refresh();
    }

    // [MenuItem("Tools/Select Object Set Active %q")]
    // public static void ActiveSelectObjects()
    // {
    //     Object[] objects = Selection.objects;
    //     if (objects != null && objects.Length > 0)
    //     {
    //         for (int i = 0; i < objects.Length; i++)
    //         {
    //             if (objects[i] is GameObject)
    //             {
    //                 GameObject go = objects[i] as GameObject;
    //                 go.SetActive(!go.activeSelf);
    //             }
    //         }
    //     }
    // }

    [MenuItem("Tools/重启Unity编辑器")]
    public static void ResetUnityEditor()
    {
        EditorApplication.OpenProject($"{Application.dataPath}/../");
    }

    // [MenuItem("Tools/刷新热更工程/<JsonDefine.cs>")]
    // public static void RefreshDataAsset()
    // {
    //     EditorAutomation.RefreshJsonDefine();
    // }

    // [MenuItem("Tools/刷新热更工程/<MsgCodeExt.cs>")]
    // public static void RefreshNetwordMsgDecode()
    // {
    //     EditorAutomation.RefreshMsgCodeExt();
    // }

    // [MenuItem("Tools/刷新热更工程/<RoleDataExt.cs>")]
    // public static void RefreshRoleDataExt()
    // {
    //     EditorAutomation.RefreshRoleDataExt();
    // }
    
    // [MenuItem("Tools/刷新热更工程/<RoleDataExt.cs>--Debug")]
    // public static void RefreshRoleDataExtDebug()
    // {
    //     EditorAutomation.RefreshRoleDataExt(true);
    // }
    
    [MenuItem("Tools/Delete All PlayerPrefs")]
    public static void PlayerPrefsDeleteAll()
    {
        PlayerPrefs.DeleteAll();
    }
    
    // [MenuItem("Tools/Excel表配置数据检查")]
    // public static void CheckExcelCfg()
    // {
    //     EditorCheckExcelCfgCorrect.CreateWindow();
    // }

    /// <summary>
    /// 导出角色Timeline
    /// </summary>
    // [MenuItem("Assets/Export Character Timeline")]
    // public static void ExportCharacterTimeline()
    // {
    //     SLMEditor.ExportCharacterTimeline.Export();
    // }
    
    [MenuItem("美术/重置特效时间参数", false, 20001)]
    public static void ResetVFXBattleTimeScale()
    {
        Shader.SetGlobalInt(BattleTimeScale, 1);
    }
}