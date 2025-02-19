using UnityEngine;

public class PoisonTower : TowerBase
{
    public float poisonDamagePerSecond = 5f;

    protected override void ApplySpecialEffects(Bullet bulletScript)
    {
        bulletScript.hasPoisonEffect = true;
        bulletScript.poisonDamagePerSecond = poisonDamagePerSecond;
    }
}