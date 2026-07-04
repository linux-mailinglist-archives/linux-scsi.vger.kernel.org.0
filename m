Return-Path: <linux-scsi+bounces-25592-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yk4bB5tcSGrFpQAAu9opvQ
	(envelope-from <linux-scsi+bounces-25592-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Jul 2026 03:06:35 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E370653C
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Jul 2026 03:06:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25592-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25592-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 297E1301EB55
	for <lists+linux-scsi@lfdr.de>; Sat,  4 Jul 2026 01:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B57D176238;
	Sat,  4 Jul 2026 01:06:26 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03006208D0;
	Sat,  4 Jul 2026 01:06:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783127186; cv=none; b=Q2GdSJPSoxaYnajPzQ79qee2MfPN4FW0qZ6kukR/3zRh10Ay1cIWiOflj8okQiQk0MTtERdKGrBraNxCfxHF3O9xUt7SBl/Nf+fFivVQxBqa9Gb+8LvZOYXQ+8SwYentCgPf1ohABKvw9nvaToH2VrQiHwXy4Xm/eyh7RJ8Dunw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783127186; c=relaxed/simple;
	bh=F89fdDAs+kAGb936oj/nK0HqJpAaWQWF4Eruo4NSst0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsaCS2DOpWJ8O+R8KaD2Er/0C6PiRkVH/SwQZ/9bCGKPHWDTIP+uXkLwzbRlbwNJ8it3+E+NeeAgkQBa2OlZyUvml0h4HoSfT47kZG/YM1HU1DBGeoL6zcC6owd+b7bX+tDoHHKNyfFcUIii6YEDTHTo1/3Qa/i4J4EUNhJeI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAD3RMiNXEhqLIPEFg--.57380S2;
	Sat, 04 Jul 2026 09:06:21 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Adam Radford <aradford@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] scsi: 3w-sas: bound firmware error string parsing
Date: Sat,  4 Jul 2026 09:06:19 +0800
Message-ID: <20260704010619.81878-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3RMiNXEhqLIPEFg--.57380S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4kKw1kJw18Ar48CF1rJFb_yoW5XrW8pw
	4FgasxJryUJw13ArnxJw1UAr45Cas2yFWFg34rZ34IqrWUGr1YyFySkr18uFyUKryxAw42
	qrsYk39xCF1kArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBmh
	wUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:aradford@gmail.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,HansenPartnership.com,oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25592-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 953E370653C

3w-sas parses two NUL-separated firmware strings from the fixed
err_specific_desc[] field.  The AEN and sense paths locate the second
string with strlen(first) + 1 before guaranteeing that the first
string is terminated inside the array.

Force a terminator in the fixed field before parsing, use strnlen()
for the first and optional second strings, and copy only the bytes
known to reside in err_specific_desc[].

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/scsi/3w-sas.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -227,6 +227,7 @@
 	unsigned short aen;
 	char host[16];
 	char *error_str;
+	size_t desc_len, error_len;
 
 	tw_dev->aen_count++;
 
@@ -250,11 +251,21 @@
 	tw_dev->error_sequence_id++;
 
 	/* Check for embedded error string */
-	error_str = &(header->err_specific_desc[strlen(header->err_specific_desc)+1]);
-
 	header->err_specific_desc[sizeof(header->err_specific_desc) - 1] = '\0';
-	event->parameter_len = strlen(header->err_specific_desc);
-	memcpy(event->parameter_data, header->err_specific_desc, event->parameter_len + 1 + strlen(error_str));
+	desc_len = strnlen(header->err_specific_desc,
+			   sizeof(header->err_specific_desc));
+	error_str = "";
+	error_len = 0;
+	if (desc_len + 1 < sizeof(header->err_specific_desc)) {
+		error_str = &header->err_specific_desc[desc_len + 1];
+		error_len = strnlen(error_str,
+				    sizeof(header->err_specific_desc) -
+				    desc_len - 1);
+	}
+
+	event->parameter_len = desc_len;
+	memcpy(event->parameter_data, header->err_specific_desc,
+	       desc_len + (error_len ? 1 + error_len : 0));
 	if (event->severity != TW_AEN_SEVERITY_DEBUG)
 		printk(KERN_WARNING "3w-sas:%s AEN: %s (0x%02X:0x%04X): %s:%s.\n",
 		       host,
@@ -862,12 +873,19 @@
 	TW_Command_Full *full_command_packet;
 	unsigned short error;
 	char *error_str;
+	size_t desc_len;
 
 	header = tw_dev->sense_buffer_virt[i];
 	full_command_packet = tw_dev->command_packet_virt[request_id];
 
 	/* Get embedded firmware error string */
-	error_str = &(header->err_specific_desc[strlen(header->err_specific_desc) + 1]);
+	header->err_specific_desc[sizeof(header->err_specific_desc) - 1] = '\0';
+	desc_len = strnlen(header->err_specific_desc,
+			   sizeof(header->err_specific_desc));
+	if (desc_len + 1 < sizeof(header->err_specific_desc))
+		error_str = &header->err_specific_desc[desc_len + 1];
+	else
+		error_str = "";
 
 	/* Don't print error for Logical unit not supported during rollcall */
 	error = le16_to_cpu(header->status_block.error);


