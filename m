Return-Path: <linux-scsi+bounces-16920-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63898B428F1
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Sep 2025 20:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74081A85B13
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Sep 2025 18:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E6836809C;
	Wed,  3 Sep 2025 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuTkKTjo"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2373629B8;
	Wed,  3 Sep 2025 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925093; cv=none; b=XOZ1W5JgYb/382n5cZOlvXHk2hwydnm96/XsyBGNPi0loXDqclJlOZHZIMyhdww/tbjW1qaJq8EprUigZl8UEX12TU3O4HJANATzV1RDIuEs2Sw2INAjXOAnGuRoy7bR+GZu372jiHoP55Bq1UlZgCzLVDNAheIAmHYNe/0UIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925093; c=relaxed/simple;
	bh=GsUokiikwbKp5vg1/26TrgCL7azSzjz7RAsIuuQWZKg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X7IskcLbfTS++/MTHiAac3/s1p9zuo6/BZ/TEAeeRFRvl8fqYR+dnPhBRCwBYmozigbiUP6rItQijPBRwhHOcIuiVZ1PLliCsR7i4b4iYNsft6itCakVMnwqKx6RAezySekiSXAqM36MKWj2bneaLGRJdOBWps4dnja68rUlD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuTkKTjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4ECC4CEE7;
	Wed,  3 Sep 2025 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756925093;
	bh=GsUokiikwbKp5vg1/26TrgCL7azSzjz7RAsIuuQWZKg=;
	h=Date:From:To:Cc:Subject:From;
	b=ZuTkKTjoEfTXoELvBN4x5Vvt61F9HopbzRHhVwsomujm55IvVPjrn8Dsz2VuHFiKR
	 GgaTpXgnmSo02sJ1gzW+9z4tIGzbzICm9HDSWjyiVSxr2MwW9wBKVPhiGgGudgbZtj
	 zrGuf6svxGvVDj2Om5BI5Qfbdwuu5499T9DaLs2ixe2U4G6QmW1U8ew0Yb8brCT+/3
	 0zVqM5pYO/LfsOVYTwplfkdw8S7WcWZPcRdfKt7nQqlRlpO2YytvfojS3YLKTSaLsJ
	 DPBvNlOU/yCCGABD3NMC30dLCanuLZmxE96ief2Do9IkkxIMwGvas+PcIXPUGx2g30
	 ox8dKnYCeMqIQ==
Date: Wed, 3 Sep 2025 20:44:48 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jack Wang <jinpu.wang@cloud.ionos.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] scsi: pm80xx: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <aLiMoNzLs1_bu4eJ@kspp>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declarations to the end of the corresponding
structures. Notice that `struct ssp_response_iu` is a flexible
structure, this is a structure that contains a flexible-array member.

With these changes fix the following warnings:

drivers/scsi/pm8001/pm8001_hwi.h:342:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/scsi/pm8001/pm80xx_hwi.h:561:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/pm8001/pm8001_hwi.h | 4 +++-
 drivers/scsi/pm8001/pm80xx_hwi.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.h b/drivers/scsi/pm8001/pm8001_hwi.h
index fc2127dcb58d..7dc7870a8f86 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.h
+++ b/drivers/scsi/pm8001/pm8001_hwi.h
@@ -339,8 +339,10 @@ struct ssp_completion_resp {
 	__le32	status;
 	__le32	param;
 	__le32	ssptag_rescv_rescpad;
-	struct ssp_response_iu  ssp_resp_iu;
 	__le32	residual_count;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct ssp_response_iu  ssp_resp_iu;
 } __attribute__((packed, aligned(4)));
 
 
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
index eb8fd37b2066..21afc28d9875 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -558,8 +558,10 @@ struct ssp_completion_resp {
 	__le32	status;
 	__le32	param;
 	__le32	ssptag_rescv_rescpad;
-	struct ssp_response_iu ssp_resp_iu;
 	__le32	residual_count;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct ssp_response_iu ssp_resp_iu;
 } __attribute__((packed, aligned(4)));
 
 #define SSP_RESCV_BIT	0x00010000
-- 
2.43.0


