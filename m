Return-Path: <linux-scsi+bounces-21986-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PGmBXO+s2kCagAAu9opvQ
	(envelope-from <linux-scsi+bounces-21986-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 08:36:19 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4C27ED9A
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 08:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FE23307E869
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361B335F61F;
	Fri, 13 Mar 2026 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nmqTLBlT"
X-Original-To: linux-scsi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2A36C0B3;
	Fri, 13 Mar 2026 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387298; cv=none; b=cdAl6jxZzix1T4QbcYyE/xeqVc73xBzCtBiZfgaJ26Ulv2EN+S6zKlpYxNuBRK+LcUvbb4ZxFwYhVKy2rlLlqGIqOk4BQEkP/53XhKofVEHrnwsfJrRgnqXBXQStCEHiiyjMQTF2dB1vcb17846g7RfqZtK2amj1K0FzJlgonDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387298; c=relaxed/simple;
	bh=PypqsTt1fvRM7AmLMYfHt0aHeG4hP+rkSLLtDFEi9Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvKCl4XMwC95KtB8QbxUt0U+MLm+4ewYR9p/mzc091SJyUh+ti7hxb6eRMXRcQpEKMPKnNoynrJG0iVwUPeOoQk1MKFlR/v0WkE5VfFNUpZVA6U9NK1UXBStsVUbZ7dMZG6dCEySQbudnSGQd9Q7XEES0E2bEu2tAUBRg9mwJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nmqTLBlT; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kG
	labob2fDnXAyXzBWkkDwb8eKGkdDcTZFDT0kAEQJo=; b=nmqTLBlToCd4EM4hMl
	dr4M/u1tPLeykDIMrCOmRQLqqvt3/hD21j4v1WPZw5/+yl2M+7lEqBMHzGybQzzw
	9FTXuJi8ibOwFMPcILG6BJaFypYPbZrPzEwcotM59Si2aXkU3iVqsvLhgjEK9IG/
	RJAv4aLoXmD+ByA6JYH90nyA0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H5P4vbNpeSPcAg--.42535S3;
	Fri, 13 Mar 2026 15:34:18 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: bvanassche@acm.org
Cc: axboe@kernel.dk,
	fujita.tomonori@lab.ntt.co.jp,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v7 2/3] bsg: add io_uring command support to generic layer
Date: Fri, 13 Mar 2026 15:34:14 +0800
Message-Id: <20260313073415.102437-2-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <96545a0f-2cdf-47ae-bf15-bfb33a35c799@acm.org>
References: <20260312092237.2464560-1-yangxiuwei@kylinos.cn> <20260312092237.2464560-2-yangxiuwei@kylinos.cn> <96545a0f-2cdf-47ae-bf15-bfb33a35c799@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H5P4vbNpeSPcAg--.42535S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gr1fKF18Kry7AF1DGrWDXFb_yoW8Jr48pF
	WrWayjyas2gr18CFy0ya17urnYq3s7Gw48JrWF9a4rKwn0krnY9Fy09r4j9FZ7ZrZ7WFWF
	gF42k34DWw1qv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmzuZUUUUU=
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6hr0hWmzvfqQ7AAA3g
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21986-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid]
X-Rspamd-Queue-Id: 6DC4C27ED9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bart,

On 3/12/26 7:33 PM, Bart Van Assche wrote:
> On 3/12/26 2:22 AM, Yang Xiuwei wrote:
>> +static int bsg_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
>> +{
>> +	struct request_queue *q;
>> +	struct bsg_device *bd;
>> +	bool open_for_write = ioucmd->file->f_mode & FMODE_WRITE;
>> +	int ret;
>> +
>> +	bd = to_bsg_device(file_inode(ioucmd->file));
>> +	q = bd->queue;
>>
>> Please combine the above assignments with the declarations of the
>> modified variables.
>

To follow your suggestion, I now combine the declarations with the
initializations, but I had to keep the dependency order between `bd`
and `q`, since `q` is initialized from `bd->queue`. The current version
looks like this:

        struct bsg_device *bd = to_bsg_device(file_inode(ioucmd->file));
        bool open_for_write = ioucmd->file->f_mode & FMODE_WRITE;
        struct request_queue *q = bd->queue;
        int ret;
		
This way we respect the declaration+initialization style and keep the
data dependency clear, while following the reverse Christmas tree style
as far as it does not conflict with the dependency.
Does this arrangement look reasonable to you, or would you prefer a
different ordering here?

Thanks,
Yang Xiuwei


