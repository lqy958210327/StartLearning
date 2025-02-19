using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI; // 用于访问UI元素

public class GameManager : MonoBehaviour
{
    public static GameManager instance; // 单例模式
    public List<Wave> waves = new List<Wave>(); // 波次列表
    public int currentWaveIndex = 0; // 当前波次索引
    public int score = 0; // 得分
    public Text scoreText; // 显示得分的UI文本
    public bool gameOver = false; // 游戏结束标志

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
            DontDestroyOnLoad(gameObject); // 在加载新场景时不销毁此对象
        }
        else
        {
            Destroy(gameObject); // 如果已经存在实例，则销毁当前对象
        }

        StartCoroutine(StartWaves()); // 开始波次
    }

    private IEnumerator StartWaves()
    {
        while (!gameOver && currentWaveIndex < waves.Count)
        {
            StartCoroutine(SpawnEnemies(waves[currentWaveIndex]));
            yield return new WaitForSeconds(waves[currentWaveIndex].intervalBetweenSpawns);
            currentWaveIndex++;
        }

        if (currentWaveIndex >= waves.Count)
        {
            gameOver = true; // 所有波次完成后游戏结束
            // 可以在这里添加游戏结束的逻辑，比如显示胜利画面
        }
    }

    private IEnumerator SpawnEnemies(Wave wave)
    {
        for (int i = 0; i < wave.enemyCount; i++)
        {
            // 在这里添加生成敌人的逻辑
            // 例如：Instantiate(enemyPrefab, spawnPoint.position, spawnPoint.rotation);
            yield return new WaitForSeconds(wave.spawnInterval);
        }
    }

    public void AddScore(int points)
    {
        score += points;
        scoreText.text = "Score: " + score.ToString();
    }

    // Wave类定义（可以在同一个脚本中或作为单独的脚本）
    [System.Serializable]
    public class Wave
    {
        public int enemyCount;
        public float spawnInterval;
        public float intervalBetweenSpawns; // 波次之间的间隔（可选）
    }
}