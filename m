Return-Path: <linux-scsi+bounces-21988-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMS1Eba+s2kCagAAu9opvQ
	(envelope-from <linux-scsi+bounces-21988-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 08:37:26 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64F27EDAA
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 08:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA9C330EE7B5
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CAE347BA7;
	Fri, 13 Mar 2026 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oYlKDHXj"
X-Original-To: linux-scsi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F3340A51;
	Fri, 13 Mar 2026 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387324; cv=none; b=iD67mXxEVuLCB6wQhqLGGY4a2sbfpNp7gsNdAmifHLtCwYx9oC6os2MRVRWdF6f1SYmBUlazO/Z82A8PJhILga5mg0dqjOzaTt0/LRoPaYt5GKHTyYqDgrcTT19qiaC77g9oBJXp6VgT0WjN3Zgxt1X7i4/IPO1qaY7ZC1wFVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387324; c=relaxed/simple;
	bh=4Ue++4Hb/qJaxI72Mrzhg0z9YGqNtKMwSslQ1SN+qTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAnuFMXy6J8ezHk/HyUu6kbFvJOtHbjg1dxKIVDeeaZehbCxrJd66IDu5wSVB2YB0A/R9Z9pX7RvG9uO+Rmhk8Lg4jtmOWKRbTN2NkoW5uzBf65ZaxNNWseQ29XrTXxZH6CXVoKCZeLojgdBRvKBaR3l4v53IsQxgvmKOpOC2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oYlKDHXj; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=yCpoBGZSziwxHEFh5uCWzsxZiLinKocXMAN0ScbxSq0=;
	b=oYlKDHXjXYU63wqIxf2/JXeJcuoabY8S2aw/mWbAiIL7nS6V6q7uR+R4hDK9dO
	QeG7Neo1ReDiG4yRwEcBQOSlUSpG6ScEjcrj5WmG+0arDK8ubHHZniTe/gc3Uukf
	WlN9ugaL+uTMNZIbfaBQ9d33THlWaSqYGlpHi8NEAjqjk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H5P4vbNpeSPcAg--.42535S4;
	Fri, 13 Mar 2026 15:34:18 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: bvanassche@acm.org
Cc: axboe@kernel.dk,
	fujita.tomonori@lab.ntt.co.jp,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v7 3/3] scsi: bsg: add io_uring passthrough handler
Date: Fri, 13 Mar 2026 15:34:15 +0800
Message-Id: <20260313073415.102437-3-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e6167003-82e4-4814-9e11-d1609681b5a9@acm.org>
References: <20260312092237.2464560-1-yangxiuwei@kylinos.cn> <20260312092237.2464560-4-yangxiuwei@kylinos.cn> <e6167003-82e4-4814-9e11-d1609681b5a9@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H5P4vbNpeSPcAg--.42535S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW8Wry7ZFW7Kr4rtFW3Awb_yoW5Jw1kpF
	W5Ka1UJF4DWr1F9Fnrtw4DuFyfZws5C3W3KFW5Cw4UCr1DAr929F4UKF18ZF1avrnrCFyI
	qr4vvFWqkr1qva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBCJQUUUUU=
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwRr0hWmzvfqLFgAA3q
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21988-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid]
X-Rspamd-Queue-Id: AC64F27EDAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bart,

On 3/12/26 7:41 PM, Bart Van Assche wrote:
> On 3/12/26 2:22 AM, Yang Xiuwei wrote:
>> +/*
>> + * Per-command BSG SCSI PDU stored in io_uring_cmd.pdu[32].
>> + * Holds temporary state between submission, completion and task_work.
>> + */
>> +struct scsi_bsg_uring_cmd_pdu {
>> +	struct bio *bio;		/* mapped user buffer, unmap in task work */
>> +	struct request *req;		/* block request, freed in task work */
>> +	u64 response_addr;		/* user space response buffer address */
>> +};
>
> A static_assert() that verifies that sizeof(struct
> scsi_bsg_uring_cmd_pdu) is less than or equal to the size of
> ((struct io_uring_cmd *)NULL)->pdu seems appropriate here.
>

Will add a static_assert() in scsi_bsg.c to ensure the PDU fits in
io_uring_cmd->pdu, e.g.:

        static_assert(sizeof(struct scsi_bsg_uring_cmd_pdu) <=
                      sizeof_field(struct io_uring_cmd, pdu));

>> +struct scsi_bsg_uring_cmd_pdu *pdu;
>> +struct io_uring_cmd *ioucmd = io_uring_cmd_from_tw(tw_req);
>> +struct scsi_cmnd *scmd;
>> +struct request *rq;
>> +u64 res2;
>> +int ret = 0;
>> +u8 driver_status = 0;
>> +u8 sense_len_wr = 0;
>> +
>> +pdu = scsi_bsg_uring_cmd_pdu(ioucmd);
>> +rq = pdu->req;
>> +scmd = blk_mq_rq_to_pdu(rq);
>
> Please combine the above three assignments with the above declarations
> since that is the style followed by most kernel code.
>

Sorry for the noise here — in v6 I did not change this part, but in v7
I took the liberty to tweak the ordering myself. Done. I will combine
the declarations with initializers in scsi_bsg_uring_task_cb() in v8
while keeping the data dependency and reverse Christmas tree style, e.g.:

	struct io_uring_cmd *ioucmd = io_uring_cmd_from_tw(tw_req);
	struct scsi_bsg_uring_cmd_pdu *pdu = scsi_bsg_uring_cmd_pdu(ioucmd);
	struct request *rq = pdu->req;
	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);

Additionally, for the `scsi_bsg_map_user_buffer()` helper in v7 I tried
to follow the same principle (dependency first, then length) when
ordering the initializations around `cmd`, `is_write`, `buf_addr` and
`buf_len`. If you think the current ordering there should be adjusted as
well, I'm happy to rework that in v8. In particular, when there is a
tension between keeping the reverse Christmas tree order and making
data/control dependencies explicit in the declaration order, I would
very much appreciate your advice on how to handle such cases, so that I
can do better here and in future patches.

Thanks for the review.

Best regards,
Yang Xiuwei


