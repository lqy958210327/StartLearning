using GameOldBoy.Rendering;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class Demo : MonoBehaviour
{
    TAAComponent taa;

    bool taaEnabled;
    private bool blurSharpenFilter;
    private bool clipAABB;
    private bool isToneMap;
    private bool bicubicFilter;
    private bool varianceClipping;
    private bool sharpernFilter;
    private bool dilation;
    
    int blend;
    float Blend
    {
        get
        {
            return 1 - 1f / blend;
        }
        set
        {
            blend = (int)(1 / (1 - value));
        }
    }

    bool antiGhosting;
    bool vSync = true;

    int frameCount = 0;
    float timer = 0;
    private float stability;
    private float historySharpening;
    private float sharpenFilter;
    int fps = 0;

    UniversalRenderPipelineAsset renderPipelineAsset;
    int renderScale;
    float RenderScale
    {
        get
        {
            return renderScale / 10f;
        }
        set
        {
            renderScale = (int)(value * 10);
        }
    }

    void Start()
    {
        taa = GetComponent<TAAComponent>();
        taaEnabled = taa.Enabled;
        Blend = taa.Blend;
        antiGhosting = taa.AntiGhosting;
        blurSharpenFilter = taa.UseBlurSharpenFilter;
        clipAABB = taa.UseClipAABB;
        isToneMap = taa.UseTonemap;
        bicubicFilter = taa.UseBicubicFilter;
        varianceClipping = taa.UseVarianceClipping;
        stability = taa.Stability;
        historySharpening = taa.HistorySharpening;
        dilation = taa.UseDilation;
        
        QualitySettings.vSyncCount = 1;
        renderPipelineAsset = (UniversalRenderPipelineAsset)GraphicsSettings.currentRenderPipeline;
        RenderScale = renderPipelineAsset.renderScale;
    }

    void Update()
    {
        // fps
        timer += Time.deltaTime;
        frameCount++;
        if (timer >= 1)
        {
            timer -= 1;
            fps = frameCount;
            frameCount = 0;
        }

        if (taaEnabled != taa.Enabled)
        {
            taa.Enabled = taaEnabled;
        }
        if (Blend != taa.Blend)
        {
            taa.Blend = Blend;
        }
        if (antiGhosting != taa.AntiGhosting)
        {
            taa.AntiGhosting = antiGhosting;
        }
        if (RenderScale != renderPipelineAsset.renderScale)
        {
            renderPipelineAsset.renderScale = RenderScale;
        }

        if (stability != taa.Stability)
        {
            taa.Stability = stability;
        }

        if (historySharpening != taa.HistorySharpening)
        {
            taa.HistorySharpening = historySharpening;
        }

        if (sharpenFilter != taa.SharpenStrength)
        {
            taa.SharpenStrength = sharpenFilter;
        }

        if (blurSharpenFilter != taa.UseBlurSharpenFilter)
        {
            taa.UseBlurSharpenFilter = blurSharpenFilter;
        }

        if (clipAABB != taa.UseClipAABB)
        {
            taa.UseClipAABB = clipAABB;
        }

        if (isToneMap != taa.UseTonemap)
        {
            taa.UseTonemap = isToneMap;
        }

        if (varianceClipping != taa.UseVarianceClipping)
        {
            taa.UseVarianceClipping = varianceClipping;
        }

        if (dilation != taa.UseDilation)
        {
            taa.UseDilation = dilation;
        }

        if (bicubicFilter != taa.UseBicubicFilter)
        {
            taa.UseBicubicFilter = bicubicFilter;
        }
        // if (vSync != QualitySettings.vSyncCount > 0)
        // {
        //     QualitySettings.vSyncCount = vSync ? 1 : 0;
        // }
    }

    private void OnGUI()
    {
        float x = 20, y = 20;
        GUI.Box(new Rect(x, y, 240, 485), $"FPS:{fps}");
        x += 20; y += 30;
        taaEnabled = GUI.Toggle(new Rect(x, y, 100, 30), taaEnabled, "TAA Enabled");
        GUI.enabled = taaEnabled;
        y += 30;
        GUI.Label(new Rect(x, y, 100, 30), "Blend");
        blend = (int)GUI.HorizontalSlider(new Rect(x + 40, y + 5, 100, 30), blend, 1, 32);
        GUI.Label(new Rect(x + 145, y, 50, 20), $"{Blend.ToString("f5")}");
        y += 30;
        antiGhosting = GUI.Toggle(new Rect(x, y, 100, 30), antiGhosting, "Anti-Ghosting");
        GUI.enabled = true;
        y += 30;
        clipAABB = GUI.Toggle(new Rect(x, y, 110, 30), clipAABB, "ClipAABB");
        y += 30;
        isToneMap = GUI.Toggle(new Rect(x, y, 110, 30), isToneMap, "ToneMap");
        y += 30;
        dilation = GUI.Toggle(new Rect(x, y, 110, 30), dilation, "Dilation");
        
        
        
        y += 30;
        varianceClipping = GUI.Toggle(new Rect(x, y, 110, 30), varianceClipping, "VarianceClipping");
        y += 30;
        GUI.Label(new Rect(x, y, 100, 30), $"Stability:{stability}");
        stability = GUI.HorizontalSlider(new Rect(x + 85, y + 5, 100, 40), stability, 0, 20);
        
        y += 40;
        bicubicFilter = GUI.Toggle(new Rect(x, y, 110, 40), bicubicFilter, "BicubicFilter");
        y += 40;
        GUI.Label(new Rect(x, y, 100, 40), $"HistorySharpening:{historySharpening}");
        historySharpening = GUI.HorizontalSlider(new Rect(x + 85, y + 5, 100, 30), historySharpening, 0, 1);
        
        y += 40;
        blurSharpenFilter = GUI.Toggle(new Rect(x, y, 110, 20), blurSharpenFilter, "BlurSharpenFilter");
        y += 20;
        GUI.Label(new Rect(x, y, 100, 30), $"SharpenStrength:{sharpenFilter}");
        sharpenFilter = GUI.HorizontalSlider(new Rect(x + 85, y + 5, 100, 50), sharpenFilter, 0, 2);
        
        // GUI.Label(new Rect(x, y, 100, 30), "Render Scale");
        // renderScale = (int)GUI.HorizontalSlider(new Rect(x + 85, y + 5, 100, 30), renderScale, 1, 20);
        // GUI.Label(new Rect(x + 190, y, 50, 20), $"{RenderScale.ToString("f1")}");
        // y += 30;
        // vSync = GUI.Toggle(new Rect(x, y, 110, 30), vSync, "VSync");
    }
}
