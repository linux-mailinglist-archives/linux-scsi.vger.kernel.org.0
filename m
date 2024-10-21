Return-Path: <linux-scsi+bounces-9027-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6E49A6789
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Oct 2024 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F88B283AE9
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Oct 2024 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825DD1EABCA;
	Mon, 21 Oct 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jWS+NcXQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377C1E47A1;
	Mon, 21 Oct 2024 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512331; cv=none; b=kCP9uLTB8l1jDW8Ha4lr2cr64Vm2oOWBuBkPAkCkQRSFwUHjIyb3byddLu3bT1Oxw30sgeLVpOlB8cjsly9aJEh74chgvN2AhsFnJXXEl4ZCc93XxCIgugBFWVlNIL/gw5FgQRbyrUXbur9LClRLyHPR1shvfuOtLu1u0nq2tR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512331; c=relaxed/simple;
	bh=LNsUbmG85GNCpHXIN0EE9pk1aZO5pmFOBVXwhrOrgn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OAUS7Gu5K1wc+JAvRENkS9rSkcePwfsG6y7ar9hK0gPyKXOmLZDXrZbWloJxoTWZ3GgOexgEMcm0QErOw0sQY9m0bSX1C/kZlQBiAPVNaEuDbd97ShzZYA2ytLbc5Q27jNhbkFW6dpI8Fr+kKe2lydODbXY2rFLOdIWXlBHoGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jWS+NcXQ; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729512329; x=1761048329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LNsUbmG85GNCpHXIN0EE9pk1aZO5pmFOBVXwhrOrgn4=;
  b=jWS+NcXQp+xWRun5mm5t/vz84B5vRst0vQd4f/3mShUur83t/MO/k7G9
   PQX5WoxeX7pjFFkl6nULzCjVG9J0387kEyjm/tjIcGrvh94o0oqc+jmFZ
   gJCKdgSUlnhinfUvRCsv1OHsCR8Ddl0TGDV9Zosl3It6yzao4E4rxYPQJ
   JPGbSmyvAudWEqYM2811bxYo5ycC+oAG9RnaFs/PqdGPPOTfJ69aq96K0
   od63gfIkRQCYjLzGSmxffpHzoX1whuKUjIjglAkehxjFbldqNNH/EMP38
   ny8Km47dW8K7vxAVFHXi/zNAVQHPqysNAKDHmO69KiEMULtggALq8VHxk
   w==;
X-CSE-ConnectionGUID: uQs5uvWdQdq2rDiTzI/wNA==
X-CSE-MsgGUID: PxGId1zkQzuscQIb4773PQ==
X-IronPort-AV: E=Sophos;i="6.11,220,1725292800"; 
   d="scan'208";a="29967095"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2024 20:05:28 +0800
IronPort-SDR: 6716351a_MzVUalNWPUUcDEqCDZRcbMFk/t+bAsQKwrExsGzXg4iFHKq
 pJdjQte/w3nn2HWtdt+hr3Gw10TrW8kRwMFiiaw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 04:03:54 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 05:05:27 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 0/4] Untie the host lock entanglement - part 1
Date: Mon, 21 Oct 2024 15:03:09 +0300
Message-Id: <20241021120313.493371-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While trying to simplify the ufs core driver with the guard() macro [1],
Bart made note of the abuse of the scsi host lock in the ufs driver.
Indeed, the host lock is deeply entangled in various flows across the
driver, as if it was some occasional default synchronization mean.

Here is the first part of defusing it, replace some of its occurrences
of host registers accesses, with a dedicated host register lock. 

Doing this in phases seems like a reasonable approach, given the myriad
use.


[1] https://lore.kernel.org/linux-scsi/0b031b8f-c07c-42ef-af93-7336439d3c37@acm.org/

Avri Altman (4):
  scsi: ufs: core: Introduce a new host register lock
  scsi: ufs: core: Use reg_lock to protect UTMRLCLR
  scsi: ufs: core: Use reg_lock to protect UTRLCLR
  scsi: ufs: core: Use reg_lock to protect HCE register

 drivers/ufs/core/ufshcd.c | 38 ++++++++++++++++++++++++--------------
 include/ufs/ufshcd.h      |  3 +++
 2 files changed, 27 insertions(+), 14 deletions(-)

-- 
2.25.1


