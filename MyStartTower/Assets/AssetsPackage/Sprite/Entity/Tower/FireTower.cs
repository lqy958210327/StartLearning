using UnityEngine;

public class FireTower : TowerBase
{
    public int extraDamage = 5; // 额外火焰伤害
    public float poisonDamagePerSecond = 5f;

    protected override void Start()
    {
        base.Start();
        // AttackRange = 10f;
    }

    protected override void Attack(Vector3 targetPosition)
    {
        base.Attack(targetPosition);
        // 这里可以添加额外的逻辑，比如发射带有额外火焰伤害的子弹
    }
 
    protected override void ApplySpecialEffects(Bullet bulletScript)
    {
        bulletScript.hasPoisonEffect = true;
        bulletScript.poisonDamagePerSecond = poisonDamagePerSecond;
    }
}