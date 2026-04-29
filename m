Return-Path: <linux-scsi+bounces-23447-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM8FBgl18mkHrgEAu9opvQ
	(envelope-from <linux-scsi+bounces-23447-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2026 23:15:53 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE849A7D3
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2026 23:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B421A3004D38
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2026 21:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8732F12A1;
	Wed, 29 Apr 2026 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Nxmh1xQ3"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B81274B3B
	for <linux-scsi@vger.kernel.org>; Wed, 29 Apr 2026 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497345; cv=none; b=dQESs3a/X13EWr8LnTc07U3EUUx5/Z582cy9bxFcvR/SLSm966dkIoqvNgu2gW8LypJm9a8psqcF4LZxlU476Z6CNITOI3C+SCCuq6CtspFtLDnHlB38yApfpbfXCsezBulapaPO9cvu5Y/dXrCuvEeZKU3jTAFmC7VLsPcJ9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497345; c=relaxed/simple;
	bh=jzXbXcl5Fqa+KvUMuKxpDAt8jnujQI/x455Tm2MuDz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmGcIZ+sjJ3vU4fXmUXMRCL22WSHFnA4DZ5Kw2VwMOLkbhezjCd59sy2iS4+BVIbXmx+P+jyVLnXA309p72DcELs2w4ZrCotuOF0C6AC9/bPxrkFwUAdCol9+72J49DJz/dFLfvzz7nTRcY8nYuL8P7xctIWJ1R4qp+Z30OpbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Nxmh1xQ3; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g5VT6061dz1XM6J7;
	Wed, 29 Apr 2026 21:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1777497335; x=1780089336; bh=QdCb9gkBV9gvsnxl0J8va6PC
	VNN7tHvWE3K9yAQnTBQ=; b=Nxmh1xQ3ymWMmI4y5qn1T4PYBpaLL8WmV04+dfpw
	/4oNYvhzsWXNUQMEL7FwW/U5cJ77S9bNhCbqVfc7iJ/GcxPf6Axz0fL+JlZCGmDZ
	VOPA4kSDk2F7vXBiAgfu45Wf0aA+py9JdxJAtd3rIpFEAiKgWeRn6iT33yyrLrTL
	lsh4Xo42mAKuTeTHJ3yeSYbbr67mQnDOG38gC0d3BZJT63FaQHmyI8IQaKEOCXKH
	Rydg5xCvfhFuX5nO9qsWSlYHzW70YfKY8Wa/WY6sOGs7hoYGzSHLaZaUys7f+nMX
	d09tQbLGlqFD9E0vHCqbsjKqiAOT/UMNPDjaxwFDJHZsvQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2VqzLdsU-UlY; Wed, 29 Apr 2026 21:15:35 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g5VT16W7yz1XM31H;
	Wed, 29 Apr 2026 21:15:33 +0000 (UTC)
Message-ID: <e6f33258-75a7-4d98-bc45-77decbad482c@acm.org>
Date: Wed, 29 Apr 2026 14:15:32 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] scsi: Protect INQUIRY sysfs attributes with mutex
To: Brian Bunker <brian@purestorage.com>, linux-scsi@vger.kernel.org
Cc: hare@suse.de, Krishna Kant <krishna.kant@purestorage.com>
References: <0a89cb03-31d6-4f5f-a84c-a838d4d99ab5@suse.de>
 <20260429012733.40855-1-brian@purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260429012733.40855-1-brian@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ADDE849A7D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23447-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 4/28/26 6:27 PM, Brian Bunker wrote:
> +sdev_show_##field(struct device *dev, struct device_attribute *attr,	\
> +		  char *buf)						\
> +{									\
> +	struct scsi_device *sdev = to_scsi_device(dev);			\
> +	ssize_t ret;							\
> +									\
> +	mutex_lock(&sdev->inquiry_mutex);				\
> +	ret = snprintf(buf, 20, "%d\n", sdev->field);			\
> +	mutex_unlock(&sdev->inquiry_mutex);				\
> +	return ret;							\
> +}									\

Please use guard()() and sysfs_emit() in new code and remove the "ret"
variable.

> +static DEVICE_ATTR(field, S_IRUGO, sdev_show_##field, NULL)
> +
> +/*
> + * sdev_rd_inquiry_attr_str: macro to create a function and attribute for a
> + * read-only INQUIRY-derived string field. The inquiry_mutex protects
> + * against concurrent updates during device rescan.
> + */
> +#define sdev_rd_inquiry_attr_str(field, accessor, len)			\
> +static ssize_t								\
> +sdev_show_##field(struct device *dev, struct device_attribute *attr,	\
> +		  char *buf)						\
> +{									\
> +	struct scsi_device *sdev = to_scsi_device(dev);			\
> +	ssize_t ret;							\
> +									\
> +	mutex_lock(&sdev->inquiry_mutex);				\
> +	if (sdev->inquiry)						\
> +		ret = snprintf(buf, 20, "%.*s\n", len,			\
> +			       accessor(sdev->inquiry));		\
> +	else								\
> +		ret = snprintf(buf, 20, "\n");				\
> +	mutex_unlock(&sdev->inquiry_mutex);				\
> +	return ret;							\
> +}									\

Same comment here.

> @@ -915,12 +951,17 @@ static ssize_t show_inquiry(struct file *filep, struct kobject *kobj,
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct scsi_device *sdev = to_scsi_device(dev);
> +	ssize_t ret;
>   
> +	mutex_lock(&sdev->inquiry_mutex);
>   	if (!sdev->inquiry)
> -		return -EINVAL;
> +		ret = -EINVAL;
> +	else
> +		ret = memory_read_from_buffer(buf, count, &off, sdev->inquiry,
> +					       sdev->inquiry_len);
> +	mutex_unlock(&sdev->inquiry_mutex);
>   
> -	return memory_read_from_buffer(buf, count, &off, sdev->inquiry,
> -				       sdev->inquiry_len);
> +	return ret;
>   }
Also here, please use guard()() and remove the "ret" variable.

Thanks,

Bart.

