import fs from 'node:fs';
const [policyPath, subject, action] = process.argv.slice(2);
const p = JSON.parse(fs.readFileSync(policyPath, 'utf8'));
const b = p.bindings.find(x => x.principal === subject && x.enabled === true);
const allowed = Boolean(b && b.role === 'admin' && b.resource === 'production-deploy' && action === 'deploy');
console.log(JSON.stringify({subject, action, allowed, matched: b ? {principal:b.principal, role:b.role, resource:b.resource, enabled:b.enabled} : null}));
process.exit(allowed ? 0 : 77);
