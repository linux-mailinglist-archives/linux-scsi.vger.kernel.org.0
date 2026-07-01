Return-Path: <linux-scsi+bounces-25393-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YrA1KHanRGrvyQoAu9opvQ
	(envelope-from <linux-scsi+bounces-25393-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 07:36:54 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DB66E9DC9
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 07:36:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25393-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25393-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23F1330078E0
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 05:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913E36B04E;
	Wed,  1 Jul 2026 05:36:36 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B97367B6C;
	Wed,  1 Jul 2026 05:36:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884196; cv=none; b=aznkJ7OSCT7B9UC6i0C0rSgjp3E2kB7uWuOR+BDvn9mqg74fgXnI8WehyEihcZrKWk6tArr4+nKSKlbm20/SOcMkZ2ikLB4la4Yo9zhg5h2lmP/K/hGcBi025NOi+M0twYaeMZxAAcq3eACYq5zd4XilDQw2UviMjx91xYyDAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884196; c=relaxed/simple;
	bh=O8KZ/89uBb4t5wM6zxP1pL8sEHjrzoPb28RohCb36Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osuALYg8zjL50qBLAwHfSgpsZYcSJNnyOfTQCilh1Zrg2t3eXJZgFHGg0Y3bqSyTjT2ZKu3jyCXxY3V228KD2iMvQVXxVirJ7VTdcdELsuYJ64FgKh07m+RSr5LfAe/w47+4ui6j+fDQ6o6YKReLd+mtUyxhFyh3ZuhhPFLUdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowABngNdbp0Rqjc+HFg--.52043S2;
	Wed, 01 Jul 2026 13:36:28 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: hpsa: clamp physical LUN count in fallback report
Date: Wed,  1 Jul 2026 13:36:26 +0800
Message-ID: <20260701053626.44118-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABngNdbp0Rqjc+HFg--.52043S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZrWfJr4fAr4rWw15Wr15urg_yoW8JF1fpF
	Z5Ga42yF92yryfKrsrW3yv934Yqa4rJryUGa1Uu345uas8GryxWFWUWry0qFyrCrsYg3yD
	tF1kta4xWFW5WFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQo7NUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25393-lists,linux-scsi=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:don.brace@microchip.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:pengpeng@iscas.ac.cn,m:storagedev@microchip.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3DB66E9DC9

When REPORT PHYS EXTENDED is not supported,
hpsa_scsi_do_report_phys_luns() falls back to REPORT LUNS and converts
each 8-byte LUN entry into the extended report buffer. The number of
entries comes from the device-provided LUNListLength field, but the loop
did not clamp it to either the source ReportLUNdata array or the
destination ReportExtendedLUNdata array.

Clamp the converted count to both arrays and update the output
LUNListLength to match the entries that were actually copied.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/scsi/hpsa.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index a1b116cd..a7115efd 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -3797,6 +3797,10 @@ static inline int hpsa_scsi_do_report_phys_luns(struct ctlr_info *h,
 		/* Copy ReportLUNdata header */
 		memcpy(buf, lbuf, 8);
 		nphys = be32_to_cpu(*((__be32 *)lbuf->LUNListLength)) / 8;
+		nphys = min_t(u32, nphys, ARRAY_SIZE(lbuf->LUN));
+		nphys = min_t(u32, nphys, ARRAY_SIZE(buf->LUN));
+		put_unaligned_be32(nphys * sizeof(buf->LUN[0]),
+				   buf->LUNListLength);
 		for (i = 0; i < nphys; i++)
 			memcpy(buf->LUN[i].lunid, lbuf->LUN[i], 8);
 	}


