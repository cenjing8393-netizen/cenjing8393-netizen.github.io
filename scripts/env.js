'use strict';

const fs = require('fs');
const path = require('path');

function loadEnv() {
  const envFile = path.join(__dirname, '../.env');
  if (!fs.existsSync(envFile)) return;
  const content = fs.readFileSync(envFile, 'utf8');
  content.split('\n').forEach(line => {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) return;
    const eqIndex = trimmed.indexOf('=');
    if (eqIndex <= 0) return;
    const key = trimmed.slice(0, eqIndex).trim();
    const val = trimmed.slice(eqIndex + 1).trim();
    if (!process.env[key]) process.env[key] = val;
  });
}

loadEnv();

hexo.extend.filter.register('before_generate', () => {
  const adsenseId = process.env.ADSENSE_CLIENT_ID;
  if (adsenseId) hexo.theme.config.adsense_client_id = adsenseId;
  const gtmId = process.env.GTM_CONTAINER_ID;
  if (gtmId) hexo.theme.config.gtm_container_id = gtmId;
}, 1);
