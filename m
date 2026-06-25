Return-Path: <linux-scsi+bounces-25263-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SYKaHMgUPWoBwwgAu9opvQ
	(envelope-from <linux-scsi+bounces-25263-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 13:45:12 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC41C6C53D6
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 13:45:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=ef8R17VB;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25263-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25263-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB852305888E
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1683D9034;
	Thu, 25 Jun 2026 11:43:32 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A32F7F03;
	Thu, 25 Jun 2026 11:43:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387812; cv=none; b=UICfyKJAORb4049s0R1021y/A+L1TeVyoaLfNpYb5KtuMySFjhhyckTs6iIhlLP13jm7KabKWoJSuP1ukiT3bFl7JNDB0pD68OIsURUhBjdJ12SNsBgqA7Fg4rF3w7Q6P8ZhGA3BI6T1VtZv1VqCyq7wjdMUExRlKeOvbDVoT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387812; c=relaxed/simple;
	bh=hb4041T/G1TmxxwgByCVDWILi6zqo20yvNFaNye8Jhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M/btSgxM4OnJx7RsGpTGeivr1FT0QYeXWULRpc3V4aTNsPVMXkJxaYlOUfMqlQcucDM6yPhIRNGnqEndOWAB9lnF1qerxNuPMLPECNISQ7vPggi9/nMuKwbHr7QJF+gV6P4wZ2NEZTzunQABLmjxMK3nGGMlnw28M0l2WQKYRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ef8R17VB; arc=none smtp.client-ip=45.254.49.198
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43c147801;
	Thu, 25 Jun 2026 19:38:15 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] scsi: target: core: annotate LUN hlist traversals
Date: Thu, 25 Jun 2026 19:38:07 +0800
Message-Id: <20260625113807.574788-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9efe92d08503a1kunm751b1d1666b4c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZS09NVhhMHR1KT0kdSk8fT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=ef8R17VBgZuCNrQy8CbiJ6VpUXikdyh0Tj03+J7XgZ0sN4RZ+xkzg0A0AaWalaFIeOdpctlw3jXd0tS7qzmf3SCeRAxEj1ulUu8j9Z5Q9c7drWQDgG34rpWM82iXztG8fE0LObT/gEHX1Z4zBQDrlF+lkw+6yCs59OP9ofig+7U=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=tPYUfi6ZVkYCElcBCT6RfDBENOkzJ37uD47YgTrkcHE=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25263-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:runyu.xiao@seu.edu.cn,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC41C6C53D6

Some target-core writer-side helpers walk RCU hlist state while already
holding the mutex that serializes the operation:

core_free_device_list_for_node() holds nacl->lun_entry_mutex
core_clear_lun_from_tpg() holds nacl->lun_entry_mutex
core_tpg_add_node_to_devs() holds tpg->tpg_lun_mutex

The code already uses the same lockdep condition for the
rcu_dereference_check() of lun->lun_se_dev in
core_tpg_add_node_to_devs(). Pass the corresponding mutex condition to
the RCU hlist iterators as well so CONFIG_PROVE_RCU_LIST can see the
non-RCU protection.

This was found by our static analysis tool and then manually reviewed
against the current tree. In the reviewed CONFIG_PROVE_RCU_LIST triage
runs, the LUN hlist walkers produced the expected "RCU-list traversed
in non-reader section!!" warning with stacks matching
core_free_device_list_for_node(), core_clear_lun_from_tpg(), and
core_tpg_add_node_to_devs(). The change is limited to documenting the
existing protection contract.

This is a lockdep annotation cleanup. It does not change LUN list
lifetime or serialization.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/target/target_core_device.c | 6 ++++--
 drivers/target/target_core_tpg.c    | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 9db2201aa553..82aa831c69c9 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -237,7 +237,8 @@ void core_free_device_list_for_node(
 	struct se_dev_entry *deve;
 
 	mutex_lock(&nacl->lun_entry_mutex);
-	hlist_for_each_entry_rcu(deve, &nacl->lun_entry_hlist, link)
+	hlist_for_each_entry_rcu(deve, &nacl->lun_entry_hlist, link,
+				 lockdep_is_held(&nacl->lun_entry_mutex))
 		core_disable_device_list_for_node(deve->se_lun, deve, nacl, tpg);
 	mutex_unlock(&nacl->lun_entry_mutex);
 }
@@ -483,7 +484,8 @@ void core_clear_lun_from_tpg(struct se_lun *lun, struct se_portal_group *tpg)
 	list_for_each_entry(nacl, &tpg->acl_node_list, acl_list) {
 
 		mutex_lock(&nacl->lun_entry_mutex);
-		hlist_for_each_entry_rcu(deve, &nacl->lun_entry_hlist, link) {
+		hlist_for_each_entry_rcu(deve, &nacl->lun_entry_hlist, link,
+					 lockdep_is_held(&nacl->lun_entry_mutex)) {
 			if (lun != deve->se_lun)
 				continue;
 
diff --git a/drivers/target/target_core_tpg.c b/drivers/target/target_core_tpg.c
index ccff9f6e4826..74bfcaa11188 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -111,7 +111,8 @@ void core_tpg_add_node_to_devs(
 	struct se_device *dev;
 
 	mutex_lock(&tpg->tpg_lun_mutex);
-	hlist_for_each_entry_rcu(lun, &tpg->tpg_lun_hlist, link) {
+	hlist_for_each_entry_rcu(lun, &tpg->tpg_lun_hlist, link,
+				 lockdep_is_held(&tpg->tpg_lun_mutex)) {
 		if (lun_orig && lun != lun_orig)
 			continue;
 
-- 
2.34.1


