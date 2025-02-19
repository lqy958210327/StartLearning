using UnityEngine;

public class RapidFireTower : TowerBase
{
    // 攻速加成（乘以这个值来增加攻速）
    public float fireRateMultiplier = 2f;

    // protected override void Start()
    // {
    //     base.Start();
    //     // 调整攻速为基速乘以攻速加成
    //     FireRate = baseFireRate * fireRateMultiplier;
    // }
}