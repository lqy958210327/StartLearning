using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace GPUInstancer
{
    [ExecuteInEditMode]
    public class GPUInstancerPrefabMobileManager : GPUInstancerPrefabManager
    {
        private List<GPUInstancerRuntimeData> runtimeDrawDataList;
        private bool isOldUpdateBuff = false;

        public override void Awake()
        {
            this.isFrustumCulling = true;
            this.isOcclusionCulling = false;
            this.lightProbeDisabled = true;
            base.Awake();
        }


        public override void OnEnable()
        {

            if (runtimeDrawDataList == null)
            {
                runtimeDrawDataList = new List<GPUInstancerRuntimeData>();
            }

            isOldUpdateBuff = SystemInfo.maxComputeBufferInputsVertex == 0;
            StartCoroutine(DelayAddRuntimeData());
            base.OnEnable();
        }

        public override void OnDisable()
        {
            base.OnDisable();
            runtimeDrawDataList.Clear();
            runtimeDrawDataList = null;
        }

        private IEnumerator DelayAddRuntimeData()
        {
            while (runtimeDataList == null || runtimeDataList.Count == 0)
            {
                yield return null;
            }

            foreach (var data in runtimeDataList)
            {
                yield return null;
                yield return null;

                runtimeDrawDataList.Add(data);
            }
        }

        private void DispatchBufferToTexture<T>(T runtimeData, ComputeShader bufferToTextureComputeShader,
            int bufferToTextureComputeKernelID, int bufferToTextureCrossFadeKernelID = 1)
            where T : GPUInstancerRuntimeData
        {
            if (runtimeData == null || runtimeData.args == null ||
                runtimeData.transformationMatrixVisibilityBuffer == null || runtimeData.bufferSize == 0)
                return;

            for (int lod = 0; lod < runtimeData.instanceLODs.Count; lod++)
            {
                bufferToTextureComputeShader.SetBuffer(bufferToTextureComputeKernelID,
                    GPUInstancerConstants.VisibilityKernelPoperties.INSTANCE_DATA_BUFFER,
                    runtimeData.transformationMatrixVisibilityBuffer);
                bufferToTextureComputeShader.SetBuffer(bufferToTextureComputeKernelID,
                    GPUInstancerConstants.VisibilityKernelPoperties.TRANSFORMATION_MATRIX_BUFFER,
                    runtimeData.instanceLODs[lod].transformationMatrixAppendBuffer);
                bufferToTextureComputeShader.SetTexture(bufferToTextureComputeKernelID,
                    GPUInstancerConstants.BufferToTextureKernelPoperties.TRANSFORMATION_MATRIX_TEXTURE,
                    runtimeData.instanceLODs[lod].transformationMatrixAppendTexture);
                bufferToTextureComputeShader.SetBuffer(bufferToTextureComputeKernelID,
                    GPUInstancerConstants.VisibilityKernelPoperties.ARGS_BUFFER, runtimeData.argsBuffer);
                bufferToTextureComputeShader.SetInt(GPUInstancerConstants.VisibilityKernelPoperties.ARGS_BUFFER_INDEX,
                    runtimeData.instanceLODs[lod].argsBufferOffset + 1);
                bufferToTextureComputeShader.SetInt(GPUInstancerConstants.VisibilityKernelPoperties.MAX_TEXTURE_SIZE,
                    GPUInstancerConstants.TEXTURE_MAX_SIZE);

                bufferToTextureComputeShader.Dispatch(bufferToTextureComputeKernelID,
                    Mathf.CeilToInt(runtimeData.bufferSize / GPUInstancerConstants.COMPUTE_SHADER_THREAD_COUNT), 1, 1);

                if (runtimeData.hasShadowCasterBuffer)
                {
                    bufferToTextureComputeShader.SetBuffer(bufferToTextureComputeKernelID,
                        GPUInstancerConstants.VisibilityKernelPoperties.INSTANCE_DATA_BUFFER,
                        runtimeData.transformationMatrixVisibilityBuffer);
                    bufferToTextureComputeShader.SetBuffer(bufferToTextureComputeKernelID,
                        GPUInstancerConstants.VisibilityKernelPoperties.TRANSFORMATION_MATRIX_BUFFER,
                        runtimeData.instanceLODs[lod].shadowAppendBuffer);
                    bufferToTextureComputeShader.SetTexture(bufferToTextureComputeKernelID,
                        GPUInstancerConstants.BufferToTextureKernelPoperties.TRANSFORMATION_MATRIX_TEXTURE,
                        runtimeData.instanceLODs[lod].shadowAppendTexture);
                    bufferToTextureComputeShader.SetBuffer(bufferToTextureComputeKernelID,
                        GPUInstancerConstants.VisibilityKernelPoperties.ARGS_BUFFER, runtimeData.shadowArgsBuffer);
                    bufferToTextureComputeShader.SetInt(
                        GPUInstancerConstants.VisibilityKernelPoperties.ARGS_BUFFER_INDEX,
                        runtimeData.instanceLODs[lod].argsBufferOffset + 1);
                    bufferToTextureComputeShader.SetInt(
                        GPUInstancerConstants.VisibilityKernelPoperties.MAX_TEXTURE_SIZE,
                        GPUInstancerConstants.TEXTURE_MAX_SIZE);

                    bufferToTextureComputeShader.Dispatch(bufferToTextureComputeKernelID,
                        Mathf.CeilToInt(runtimeData.bufferSize / GPUInstancerConstants.COMPUTE_SHADER_THREAD_COUNT), 1,
                        1);
                }

                if (runtimeData.prototype.isLODCrossFade)
                {
                    bufferToTextureComputeShader.SetTexture(bufferToTextureCrossFadeKernelID,
                        GPUInstancerConstants.BufferToTextureKernelPoperties.LOD_DATA_TEXTURE,
                        runtimeData.instanceLODDataTexture);
                    bufferToTextureComputeShader.SetBuffer(bufferToTextureCrossFadeKernelID,
                        GPUInstancerConstants.VisibilityKernelPoperties.INSTANCE_LOD_BUFFER,
                        runtimeData.instanceLODDataBuffer);
                    bufferToTextureComputeShader.SetInt(
                        GPUInstancerConstants.VisibilityKernelPoperties.MAX_TEXTURE_SIZE,
                        GPUInstancerConstants.TEXTURE_MAX_SIZE);
                    bufferToTextureComputeShader.SetInt(
                        GPUInstancerConstants.VisibilityKernelPoperties.BUFFER_PARAMETER_BUFFER_SIZE,
                        runtimeData.bufferSize);

                    bufferToTextureComputeShader.Dispatch(bufferToTextureCrossFadeKernelID,
                        Mathf.CeilToInt(runtimeData.bufferSize / GPUInstancerConstants.COMPUTE_SHADER_THREAD_COUNT), 1,
                        1);
                }
            }
        }

        private void GPUIDrawMeshInstancedIndirect<T>(T runtimeData, Bounds instancingBounds,
            GPUInstancerCameraData cameraData, int layerMask = ~0,
            bool lightProbeDisabled = false)
            where T : GPUInstancerRuntimeData
        {
            if (runtimeData == null || runtimeData.transformationMatrixVisibilityBuffer == null ||
                runtimeData.bufferSize == 0 || runtimeData.instanceCount == 0)
                return;

            // Everything is ready; execute the instanced indirect rendering. We execute a drawcall for each submesh of each LOD.
            GPUInstancerPrototypeLOD rdLOD;
            GPUInstancerRenderer rdRenderer;
            Material rdMaterial;
            Camera rendereringCamera = cameraData.GetRenderingCamera();
            int offset = 0;
            int submeshIndex = 0;
            for (int lod = 0; lod < runtimeData.instanceLODs.Count; lod++)
            {
                rdLOD = runtimeData.instanceLODs[lod];
                bool isLODShadowCasting = runtimeData.IsLODShadowCasting(lod);
                for (int r = 0; r < rdLOD.renderers.Count; r++)
                {
                    rdRenderer = rdLOD.renderers[r];
                    if (!GPUInstancerUtility.IsInLayer(layerMask, rdRenderer.layer))
                        continue;

                    for (int m = 0; m < rdRenderer.materials.Count; m++)
                    {
                        rdMaterial = rdRenderer.materials[m];

                        submeshIndex = Math.Min(m, rdRenderer.mesh.subMeshCount - 1);
                        offset = (rdRenderer.argsBufferOffset + 5 * submeshIndex) *
                                 GPUInstancerConstants.STRIDE_SIZE_INT;

                        if (rdRenderer.rendererRef == null ||
                            rdRenderer.rendererRef.shadowCastingMode != ShadowCastingMode.ShadowsOnly)
                        {
                            Graphics.DrawMeshInstancedIndirect(rdRenderer.mesh, submeshIndex,
                                rdMaterial,
                                instancingBounds,
                                runtimeData.argsBuffer,
                                offset,
                                rdRenderer.mpb,
                                runtimeData.prototype.isShadowCasting && !runtimeData.hasShadowCasterBuffer &&
                                isLODShadowCasting
                                    ? ShadowCastingMode.On
                                    : ShadowCastingMode.Off, rdRenderer.receiveShadows, rdRenderer.layer,
                                rendereringCamera
#if UNITY_2018_1_OR_NEWER
                                , lightProbeDisabled ? LightProbeUsage.Off : LightProbeUsage.BlendProbes
#endif
                            );
                        }

                        if (runtimeData.hasShadowCasterBuffer && runtimeData.prototype.isShadowCasting &&
                            isLODShadowCasting && rdRenderer.castShadows)
                        {
                            Graphics.DrawMeshInstancedIndirect(rdRenderer.mesh, submeshIndex,
                                runtimeData.prototype.useOriginalShaderForShadow
                                    ? rdMaterial
                                    : runtimeData.shadowCasterMaterial,
                                instancingBounds,
                                runtimeData.shadowArgsBuffer,
                                offset,
                                rdRenderer.shadowMPB,
                                ShadowCastingMode.ShadowsOnly, false, rdRenderer.layer, rendereringCamera
#if UNITY_2018_1_OR_NEWER
                                , lightProbeDisabled ? LightProbeUsage.Off : LightProbeUsage.BlendProbes
#endif
                            );
                        }
                    }
                }
            }
        }

        public override void UpdateBuffers(GPUInstancerCameraData renderingCameraData)
        {
            if (isOldUpdateBuff)
            {
                if (runtimeDataList.Count > 1)
                {
                    base.UpdateBuffers(renderingCameraData);
                }
            }
            else
            {
                if (renderingCameraData != null && renderingCameraData.mainCamera != null &&
                    SystemInfo.supportsComputeShaders &&
                    runtimeDrawDataList != null)
                {
                    foreach (var drawData in runtimeDrawDataList)
                    {
                        if (isOcclusionCulling && renderingCameraData.hiZOcclusionGenerator == null)
                            SetupOcclusionCulling(renderingCameraData);

                        renderingCameraData.CalculateCameraData();

                        instancingBounds.center = renderingCameraData.mainCamera.transform.position;

                        if (lastDrawCallFrame != Time.frameCount)
                        {
                            lastDrawCallFrame = Time.frameCount;
                            timeSinceLastDrawCall = Time.realtimeSinceStartup - lastDrawCallTime;
                            lastDrawCallTime = Time.realtimeSinceStartup;
                        }


                        UpdateSpatialPartitioningCells(renderingCameraData);

                        GPUInstancerUtility.UpdateGPUBuffer(
                            GPUInstancerConstants.gpuiSettings.IsUseBothEyesVRCulling()
                                ? _cameraComputeShaderVR
                                : _cameraComputeShader, _cameraComputeKernelIDs, _visibilityComputeShader,
                            _instanceVisibilityComputeKernelIDs, drawData, renderingCameraData, isFrustumCulling,
                            isOcclusionCulling, showRenderedAmount, isInitial);
                        isInitial = false;

                        if (GPUInstancerUtility.matrixHandlingType == GPUIMatrixHandlingType.CopyToTexture)
                            DispatchBufferToTexture(drawData, _bufferToTextureComputeShader,
                                _bufferToTextureComputeKernelID, _bufferToTextureCrossFadeComputeKernelID);

                        GPUIDrawMeshInstancedIndirect(drawData, instancingBounds,
                            renderingCameraData, layerMask, lightProbeDisabled);
                    }
                }
            }
        }
    }
}