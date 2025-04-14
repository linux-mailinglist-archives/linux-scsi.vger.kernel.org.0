Return-Path: <linux-scsi+bounces-13415-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7890A879CE
	for <lists+linux-scsi@lfdr.de>; Mon, 14 Apr 2025 10:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791023B03E0
	for <lists+linux-scsi@lfdr.de>; Mon, 14 Apr 2025 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975DB258CE7;
	Mon, 14 Apr 2025 08:08:52 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB4259C85;
	Mon, 14 Apr 2025 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618132; cv=none; b=HZIR5DhnCXR/7TIpiI1Cnp3y+aoMF2m9r7977j3kgI/r/Bls2H3H78OdOaUWxZExtoguPvsOgauUXaWzHFCrhU6ZVCdNbHKO7QEQXV6PtTf78ZwOtws2qGwBx5Kf6m3GWAHD26/rDx02VNRrXVo+SttmQVVLJj/uZgGVW8KY40E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618132; c=relaxed/simple;
	bh=4GoCfFjO+Q6qsBe2qU4cD93K2hb0bVQ7KfNS41nFI8I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gwt1GqrkG5G8AUo7Scvk/nY9Pz1n3lVM7W7tqDnkt4rIXR8u1pZCGn03bRKmpwAH7iJnWvDzLNuAt9rBwjNYk+9MYgAruvIFyPmwwhcpeoL+Na65ReRoxxp7ekvNqpAOPNhn5ciKV30OtMbVetcLSHK380C4HLWg4h14PGfRPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zbfzf6Cdkz13LQ1;
	Mon, 14 Apr 2025 16:07:58 +0800 (CST)
Received: from dggpemf100013.china.huawei.com (unknown [7.185.36.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 23EEA180080;
	Mon, 14 Apr 2025 16:08:46 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemf100013.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 16:08:45 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <martin.petersen@oracle.com>, <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@huawei.com>, <liuyonglong@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: [PATCH v3 0/4] hisi_sas: Misc patches and cleanups
Date: Mon, 14 Apr 2025 16:08:41 +0800
Message-ID: <20250414080845.1220997-1-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100013.china.huawei.com (7.185.36.179)

This series contains some minor bugfix and general tidying:
- Ignore the soft reset result by calling I_T_nexus after the SATA disk
  is soft reset
- General minor tidying

Thanks!

Changes since v2:
- Fix some compile errors after applying this series.

Changes since v1:
- Remove patch 1 and come up with a better solution to fix the issue:
  https://lore.kernel.org/linux-block/eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com/
  maybe in libsas or libata.

Yihang Li (4):
  scsi: hisi_sas: Use macro instead of magic number
  scsi: hisi_sas: Code style cleanup
  scsi: hisi_sas: Call I_T_nexus after soft reset for SATA disk
  scsi: hisi_sas: Wait until eh is recovered

 drivers/scsi/hisi_sas/hisi_sas.h       |  51 +++--
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  81 ++++----
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   6 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 259 +++++++++++++++----------
 5 files changed, 236 insertions(+), 163 deletions(-)

-- 
2.33.0


