Return-Path: <linux-scsi+bounces-22425-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJIpLPhtwWnDTAQAu9opvQ
	(envelope-from <linux-scsi+bounces-22425-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 17:44:40 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8042F8B9F
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 17:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E3323238B32
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE193BED2B;
	Mon, 23 Mar 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Pnam4xV6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24D3BED2A
	for <linux-scsi@vger.kernel.org>; Mon, 23 Mar 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281695; cv=none; b=Lhulc3Ge9bCfkpUE4KUE7V5aeYBaleVzkijwIlJ6TrqcUM0+3oY6JuhVmg4rqLdzTmg2cFW4xd321+bsl726rYSUyvXSSv5YW3sEUn2XcJoekd7YufhkjZFPJhZt6rgI6MewffT0o5LY15w8FSve26hg8W96xLtgR1bqd73bQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281695; c=relaxed/simple;
	bh=fyBJF0Rb3ojGG3W0enZR4zW94KIveEVLAnTki7iglOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rgm7AXkJFmuFu2ntCH1MZYSRYl9ppg3V8iCaYeH1QgGtiq8hjPgt7a3flT36SmhCB3GO8TgoFJBWKlwRmyV3MNN1tkDjwMiykAPMziodxeBrFIibnFgPy30wAcyuddL/MgR9JCc5JIUxfwOOI7FkdXNgdWuyHnQ6dbOTyWY/Q0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Pnam4xV6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd71fb9f06so19343785a.2
        for <linux-scsi@vger.kernel.org>; Mon, 23 Mar 2026 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281693; x=1774886493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MJV3zFq/rwr+CUp0wh8JYL6rs7Ri2408vNUrLWuymw=;
        b=Pnam4xV6CjXEf/mK5NR+ZGus3/5VLgXXqQaofXV/G1FN+qBfwATWeVMRoBLYXeBGuf
         CP2JeCCGMCOZXqdmda2tnihSorDqrU1S11yeOizpwhAf69RJdf8Gp3doCRoKJZPngJCK
         ZOE7DWBYlaFQ4uS7xCFd6UntkxKhZud9amqiJq0IWdaf/YppFezMkWG9sHq2kpwYoYU7
         Xhmjna5X6AtrcLe5w2PoVhEDNQrjoKbf8YAwyi9CQv2k2vx+GeTlbbC4TI7Jd/wUXWst
         JB77WNC2kvD8SljQ/MJBW0Q1llkjBdkIkC6LByYeueWbfJispTGUtw8X+9ZWyM36ppX4
         zTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281693; x=1774886493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MJV3zFq/rwr+CUp0wh8JYL6rs7Ri2408vNUrLWuymw=;
        b=oqTS882jpzDR4muqnzjnRqkfjLnowrwd86gwugqLH0GRE1XWRV5tWVQK/gmifze3a8
         a9rlngCWI3YprOllTvNxGOrGVphBH7PNdSqgSHk4rJgfeCagxl+VVoqvchtQHFOfMNOy
         TZDnmzDzB3WhNJM+HTgQ7eAqbbe7jJ2TCRbeN13Zfq3suVzmX1isP/G1D/nzfQwwx+Rq
         9U96B4ddEUWCil99KBTNswNTe/QYivLDN37Dk/13FTpvNtrN8eE7sDpJ4/2sBOHwHd7F
         jHrMA3NoF5wPGAvBVf29qSpSDEjCUDdGw5GCCONwSaLZY1RcheL9pR7TjQGqzrkPjlkR
         HHnA==
X-Forwarded-Encrypted: i=1; AJvYcCXyXCIEJ+OoDA9SUemkZNd1FrrowctUkrMEzwaJ3prcfC5uT5xzTYXiGDbz2VR30lahE0+E3Pni85ik@vger.kernel.org
X-Gm-Message-State: AOJu0YxGqmBWs/9WJ6gS371YwSAXgOVaTLGXFKwpTPJd7dHuDUKIcEUl
	OPMlc+Ltg3O4vQvX+FvK1eUjlxD0Jk0ZrBI7uqpGs390szhOfIbBSbOH6/ARYkIktZA=
X-Gm-Gg: ATEYQzy8v9GvOjfBdy6NWOAFKjKNuD3sBC5yCklpXSa19nQV6fptHdc1bpu00mkhxFb
	HvbZkFAeWRyfwMpW17xyku8DayVR9sSlKpAbCuOFp+3th4/8cZcK3RqtF0Xa1vigxACnm7c0uE4
	Wwr7y57AkaYnK0cL0Zanu1dXenLTT/Pm7obDw7e2lmVBEXSmeiChqW+TOlfHsp3XX9kEUxwH2dA
	fWg2Pa/P59hG2BzPV6B852S1jfdwaIr3+0P5eAJGYvHqtPwwmcjygHJBU5en0fYZli080yMfwC3
	tlMtbGYKW/3Gyy8JGc4KgzePjKU4myZlqQdHOavAVAKuEgFUKgBC15EEyvLN6jXLPuEdvUaYGgy
	RrFDeoh+CYTA6HlHQ8FgoPcfPdwGxhkwvefDFJ7FKznPyGD0akLLmmZSpjpAkSwHgxaItrpLlu4
	SusDp9oSJ6luh59ntFEb/UVlAtYs3KwkDCm/ULoNp4kTHLLTnZhDGZVj3StFxJNMyBQQ==
X-Received: by 2002:a05:620a:f13:b0:8c7:a84:d0e4 with SMTP id af79cd13be357-8cfc7e9d63dmr1972995485a.24.1774281693191;
        Mon, 23 Mar 2026 09:01:33 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:32 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Bean Huo <beanhuo@micron.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 14/19] scsi: ufs: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:33 -0400
Message-ID: <20260323160052.17528-15-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bitbyteword.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22425-lists,linux-scsi=lfdr.de];
	DMARC_NA(0.00)[bitbyteword.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2F8042F8B9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/ufs/core/ufshcd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 899e663fea6e8..b27bde8ea7555 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -422,7 +422,7 @@ static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba,
 	else
 		header = &lrb->ucd_rsp_ptr->header;
 
-	trace_ufshcd_upiu(hba, str_t, header, &rq->sc.cdb,
+	trace_call__ufshcd_upiu(hba, str_t, header, &rq->sc.cdb,
 			  UFS_TSF_CDB);
 }
 
@@ -433,7 +433,7 @@ static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba,
 	if (!trace_ufshcd_upiu_enabled())
 		return;
 
-	trace_ufshcd_upiu(hba, str_t, &rq_rsp->header,
+	trace_call__ufshcd_upiu(hba, str_t, &rq_rsp->header,
 			  &rq_rsp->qr, UFS_TSF_OSF);
 }
 
@@ -446,12 +446,12 @@ static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 		return;
 
 	if (str_t == UFS_TM_SEND)
-		trace_ufshcd_upiu(hba, str_t,
+		trace_call__ufshcd_upiu(hba, str_t,
 				  &descp->upiu_req.req_header,
 				  &descp->upiu_req.input_param1,
 				  UFS_TSF_TM_INPUT);
 	else
-		trace_ufshcd_upiu(hba, str_t,
+		trace_call__ufshcd_upiu(hba, str_t,
 				  &descp->upiu_rsp.rsp_header,
 				  &descp->upiu_rsp.output_param1,
 				  UFS_TSF_TM_OUTPUT);
@@ -471,7 +471,7 @@ static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
 	else
 		cmd = ufshcd_readl(hba, REG_UIC_COMMAND);
 
-	trace_ufshcd_uic_command(hba, str_t, cmd,
+	trace_call__ufshcd_uic_command(hba, str_t, cmd,
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_1),
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2),
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3));
@@ -523,7 +523,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, struct scsi_cmnd *cmd,
 	} else {
 		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	}
-	trace_ufshcd_command(cmd->device, hba, str_t, tag, doorbell, hwq_id,
+	trace_call__ufshcd_command(cmd->device, hba, str_t, tag, doorbell, hwq_id,
 			     transfer_len, intr, lba, opcode, group_id);
 }
 
-- 
2.53.0


