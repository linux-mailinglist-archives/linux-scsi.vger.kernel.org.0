Return-Path: <linux-scsi+bounces-21165-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENrkF81Rn2k7aAQAu9opvQ
	(envelope-from <linux-scsi+bounces-21165-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 20:47:25 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AAA19CE69
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 20:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96032308F809
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 19:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1616F1548C;
	Wed, 25 Feb 2026 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zSKxLKef"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67915C158
	for <linux-scsi@vger.kernel.org>; Wed, 25 Feb 2026 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048739; cv=none; b=UQx96qDzm1e52tC+u+VKJgHCePpQ9TIwrxPZ8x4KATFO0MyzPCXZ1n8LyulWweq3fENFlakvrMcQK7mwovnokWK/mm21CJWYwxU141Tfa/LNSC8xUU2xdpt2RzfhqyVheSbjfC2h2kbSk46JgK4FyXJtwzibUaeD3W7nc8lBRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048739; c=relaxed/simple;
	bh=bmDO9nsHM3jQXFvgS/ofQ5W7+iq94kvkDZRk6kjKpsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKI5qbljk4cUeIcGJj6imlcCT2MsrYChd1cm/XvXFz04Lhi7BY04nZy1oXgiPCUJO9CQHSTZ27cCXA/KgTwpfsMs2TwyZ8haGRMxnG7JTydVvXgWC/OEISFEZ3aPdj2rlnFtIXG+NxF7C6RGvBk6oIMgvdG5OzTtXsgpK6nYQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zSKxLKef; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fLlSL17jFz1XM6J7;
	Wed, 25 Feb 2026 19:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772048735; x=1774640736; bh=JP89OuauajIco858XJ7s3e3n
	A09LiU6G8dbnXGP3kNQ=; b=zSKxLKef2N8n8FXSoP2muNsXIFU0Xg2gg4w/qxOF
	haXU3AWn1G4111dTIMV8/9B6cU8BxTTf7btFKVE0ukzpAdFHov55bZUwHzkTsY3V
	hSFJT992uhXBAszCdsKBlCPPmquVD+yUms3oFhzTVuVmQV/Ke0X/8D/Iu+KJ5Gmv
	gu8AZTZKa8HCTbeXwDbiarDiZCD4wsscK+VcahRVMWR1N7DcKAB0QBJxg4cmSmAT
	4Gvu34SlvAYDyBGsnn8h8g2Zn7g+akx0YSqLURR1wzrYjH+ZXMVxGVj/fPpg84dp
	1M9VC2RSfE1ErA+4seTj5uowicxEknmM6jQvcrCjvDUmNw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id d-03Ske_5TLB; Wed, 25 Feb 2026 19:45:35 +0000 (UTC)
Received: from [172.20.2.156] (unknown [4.28.11.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fLlSB0jp4z1XM6J5;
	Wed, 25 Feb 2026 19:45:29 +0000 (UTC)
Message-ID: <b680084c-88b1-4854-981b-316311452e56@acm.org>
Date: Wed, 25 Feb 2026 11:45:29 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ufs: core: Fix possible NULL pointer dereference in
 ufshcd_add_command_trace()
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, avri.altman@sandisk.com,
 alim.akhtar@samsung.com, jejb@linux.ibm.com, peter.wang@mediatek.com
Cc: wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
 chun-hung.wu@mediatek.com, alice.chao@mediatek.com, cc.chou@mediatek.com,
 chaotian.jing@mediatek.com, tun-yu.yu@mediatek.com,
 eddie.huang@mediatek.com, naomi.chu@mediatek.com, ed.tsai@mediatek.com
References: <20260223065657.2432447-1-peter.wang@mediatek.com>
 <177198526950.1649777.14781899060414426367.b4-ty@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <177198526950.1649777.14781899060414426367.b4-ty@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21165-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: C5AAA19CE69
X-Rspamd-Action: no action

On 2/24/26 6:08 PM, Martin K. Petersen wrote:
> Applied to 7.0/scsi-fixes, thanks!
> 
> [1/1] ufs: core: Fix possible NULL pointer dereference in ufshcd_add_command_trace()
>        https://git.kernel.org/mkp/scsi/c/30df81f2228d
Hi Martin,

Do you agree that the following should be added to this patch?

Fixes: 4a52338bf288 ("scsi: ufs: core: Add trace event for MCQ")

 From commit 4a52338bf288:

@@ -456,9 +458,16 @@ static void ufshcd_add_command_trace(struct ufs_hba 
*hba, unsigned int tag,
         }

         intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
-       doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+
+       if (is_mcq_enabled(hba)) {
+               struct ufs_hw_queue *hwq = ufshcd_mcq_req_to_hwq(hba, rq);
+
+               hwq_id = hwq->id;
+       } else {
+               doorbell = ufshcd_readl(hba, 
REG_UTP_TRANSFER_REQ_DOOR_BELL);
+       }
         trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
-                       doorbell, transfer_len, intr, lba, opcode, 
group_id);
+                       doorbell, hwq_id, transfer_len, intr, lba, 
opcode, group_id);
  }

Thanks,

Bart.


