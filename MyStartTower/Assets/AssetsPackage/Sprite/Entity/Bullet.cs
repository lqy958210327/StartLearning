using UnityEngine;

public class Bullet : MonoBehaviour
{
    public Vector3 targetPosition;
    public float speed = 10f;
    public int damage = 1; // 基本伤害
    public bool hasPoisonEffect = false;
    public float poisonDamagePerSecond = 3f;//中毒每秒伤害
    public float poisonDuration = 5f;//中毒持续时间
    public bool hasSlowEffect = false;//减速
    public float slowAmount = 0.5f; // 减速百分比

    private void Update()
    {
        // 移动子弹朝向目标
        Vector3 direction = (targetPosition - transform.position).normalized;
        transform.position += direction * speed * Time.deltaTime;

        // 检查是否击中目标（这里简化处理，仅检查是否到达目标位置附近）
        float distanceToTarget = Vector3.Distance(transform.position, targetPosition);
        if (distanceToTarget <= 0.5f) // 假设0.5是子弹的“爆炸”半径
        {
            OnHitTarget();
            Destroy(gameObject); // 销毁子弹
        }
    }

    private void OnHitTarget()
    {
        // 触发击中目标事件，这里简化处理为直接调用伤害逻辑
        Collider[] hitColliders = Physics.OverlapSphere(targetPosition, 0.5f); // 使用与子弹相同的“爆炸”半径
        foreach (Collider hitCollider in hitColliders)
        {
            IDamageable damageable = hitCollider.GetComponent<IDamageable>();
            if (damageable != null)
            {
                damageable.TakeDamage(damage);

                // 应用特殊效果
                if (hasPoisonEffect)
                {
                    damageable.ApplyPoisonEffect(poisonDamagePerSecond, poisonDuration);
                }
                if (hasSlowEffect)
                {
                    damageable.ApplySlowEffect(slowAmount);
                }
            }
        }
    }
}