Return-Path: <linux-scsi+bounces-21987-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDPKKD2+s2kCagAAu9opvQ
	(envelope-from <linux-scsi+bounces-21987-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 08:35:25 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA9D27ED7B
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 08:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75E2D3030A1E
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90566366DB6;
	Fri, 13 Mar 2026 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N+e8PPZR"
X-Original-To: linux-scsi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87B20B80B;
	Fri, 13 Mar 2026 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387322; cv=none; b=coV9pcdWKBeDSRLDKZhpuqA53pV9b86w1fGCRh3ADCJXQ0wjTjK7aTEd7w39aBvWPJyrZprNpPAAKp+SKsriLhGwP+C1/rQ1xM8W6O0TyH7MHvK+WGmoFh1FRl1f9zDebkxrOGtBh/93D8v7500m9cO/X466VUXNkA+ogSiAbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387322; c=relaxed/simple;
	bh=ELtaWFtgGSdldQHlSy0RDS1LYT4DQan8C8w1loMCkcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1BlUMBymWMVTQFgZFC07Qexfk1l2cjvr3PpsRK3g0HQwMNG36UQef5ugIHbPY86Ews88+AO98WVF8ieQXZVp3zn/E8RkV4YxNAXYpRe2cgMx+kbWwtwAIujEsBPUGr2tRDcHlzRqEQsZLPUfLlZ3ZcTRns7CygcoHBmmV4wDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N+e8PPZR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=R2
	51S6F6HhAdMKrusKTkWEQRW4kowbIzmGaUkWV/1mA=; b=N+e8PPZRZFAN69jOja
	18+MVaS4zeWdJ97yOdA/WNKjL43kdYCbHVgeBOrPHK0IsXhtGrrS1C53JeFwkl76
	m/3VxXnouBUvghIRbHbgzFel/rZpDIdQdGetSBl5nYqy4PA6rURgMD514ypZh+n6
	L4jaX0sqHO7SrVlYivCx5SkH8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H5P4vbNpeSPcAg--.42535S2;
	Fri, 13 Mar 2026 15:34:17 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: bvanassche@acm.org
Cc: axboe@kernel.dk,
	fujita.tomonori@lab.ntt.co.jp,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v7 1/3] bsg: add bsg_uring_cmd uapi structure
Date: Fri, 13 Mar 2026 15:34:13 +0800
Message-Id: <20260313073415.102437-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <574620fd-903b-4fd3-8cbb-22a3cefda645@acm.org>
References: <20260312092237.2464560-1-yangxiuwei@kylinos.cn> <20260312092237.2464560-2-yangxiuwei@kylinos.cn> <574620fd-903b-4fd3-8cbb-22a3cefda645@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H5P4vbNpeSPcAg--.42535S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF17CryrCw15JFWruF1DAwb_yoW5ZFy5pF
	W5ta10yrW5WF12kr47ZasrArWYvr48Ja42gFWUXwnrua1jvF10kF1qkFWftayxX395Ary0
	vrnFqa4rGwn7taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRN4SwUUUUU=
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwhr0hWmzvfpCPwAA3J
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21987-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:mid]
X-Rspamd-Queue-Id: 4AA9D27ED7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bart,

On 3/12/26 7:29 PM, Bart Van Assche wrote:
> On 3/12/26 2:22 AM, Yang Xiuwei wrote:
>> +struct bsg_uring_cmd {
>> +	__u64 request;		/* [i], [*i] command descriptor address */
>> +	__u32 request_len;	/* [i] command descriptor length in bytes */
>> +	__u32 protocol;		/* [i] protocol type (BSG_PROTOCOL_*) */
>> +	__u32 subprotocol;	/* [i] subprotocol type (BSG_SUB_PROTOCOL_*) */
>> +	__u32 max_response_len;	/* [i] response buffer size in bytes */
>> +
>> +	__u64 response;		/* [i], [*o] response data address */
>> +	__u64 dout_xferp;	/* [i], [*i] */
>> +	__u32 dout_xfer_len;	/* [i] bytes to be transferred to device */
>> +	__u32 dout_iovec_count;	/* [i] 0 -> "flat" dout transfer else
>> +				 * dout_xferp points to array of iovec
>> +				 */
>> +	__u64 din_xferp;	/* [i], [*o] */
>> +	__u32 din_xfer_len;	/* [i] bytes to be transferred from device */
>> +	__u32 din_iovec_count;	/* [i] 0 -> "flat" din transfer */
>> +
>> +	__u32 timeout_ms;	/* [i] timeout in milliseconds */
>> +	__u8  reserved[12];	/* reserved for future extension */
>> +};
>
> Please consider adding a static_assert() statement that verifies the
> size of this data structure at compile time. Such a statement is useful
> to document the size of the data structure, helps with verifying that
> the size is the same on all architectures and helps with verifying that
> the size doesn't change if a reserved byte is taken in use.

Good point. In v8 I plan to define BSG_URING_CMD_SIZE in the UAPI header and
add a static_assert in drivers/scsi/scsi_bsg.c to verify at compile time that
sizeof(struct bsg_uring_cmd) matches that macro, e.g.:

	/* include/uapi/linux/bsg.h */
	#define BSG_URING_CMD_SIZE	80

	/* drivers/scsi/scsi_bsg.c */
	static_assert(sizeof(struct bsg_uring_cmd) == BSG_URING_CMD_SIZE);

Does this arrangement look reasonable to you?

>> +#define BSG_SCSI_RES2_DEVICE_STATUS(res2)   ((__u8)((__u64)(res2) & 0xff))
>> +#define BSG_SCSI_RES2_DRIVER_STATUS(res2)   ((__u8)((__u64)(res2) >> 8))
>> +#define BSG_SCSI_RES2_HOST_STATUS(res2)     ((__u8)((__u64)(res2) >> 16))
>> +#define BSG_SCSI_RES2_SENSE_LEN(res2)       ((__u8)((__u64)(res2) >> 24))
>> +#define BSG_SCSI_RES2_RESID_LEN(res2)       ((__u32)((__u64)(res2) >> 32))
>> +
>> +#define BSG_SCSI_RES2_BUILD(device_status, driver_status, host_status,   \
>> +			    sense_len_wr, resid_len)			\
>> +	(((__u64)(__u32)(resid_len) << 32) |				\
>> +	 ((__u64)(__u8)(sense_len_wr) << 24) |				\
>> +	 ((__u64)(__u8)(host_status) << 16) |				\
>> +	 ((__u64)(__u8)(driver_status) << 8) |				\
>> +	 ((__u64)(__u8)(device_status)))
>
> Please convert all the above macros into inline functions because that
> will result in removal of most of the typecasts. I think that inline
> functions are allowed in uapi headers:
>
> $ git grep 'static.*inline' include/uapi | wc -l
> 354

Done. I have replaced the BSG_SCSI_RES2_* macros with static inline
functions (bsg_scsi_res2_device_status(), bsg_scsi_res2_driver_status(),
bsg_scsi_res2_host_status(), bsg_scsi_res2_sense_len(),
bsg_scsi_res2_resid_len(), and bsg_scsi_res2_build()) in the UAPI header
to improve type safety and remove redundant type casts as suggested.

Best regards,
Yang Xiuwei


