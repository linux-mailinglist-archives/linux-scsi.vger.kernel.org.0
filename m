Return-Path: <linux-scsi+bounces-22397-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAcxDXkHwWmtPwQAu9opvQ
	(envelope-from <linux-scsi+bounces-22397-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 10:27:21 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF52EF0A9
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 10:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A02EB301BA89
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDDB3806CD;
	Mon, 23 Mar 2026 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k95jdctW"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42F2F28FF
	for <linux-scsi@vger.kernel.org>; Mon, 23 Mar 2026 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257886; cv=none; b=hp5L4ZP9inYFwPI4q+vpRzF2A1oeml5iHXLV7OjLSgPx2DOhoaIXI5ntuzm0nZPS4JrTEBYvqTpywGyOu3VLRmmgDbUfYSlp9bojje57r2o1SiKftubm0uiBalWihKDfxG8OHf9+TKDK4e+Jr0FaVYAktWpk6lRonLa0tKFJ0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257886; c=relaxed/simple;
	bh=agJiL7CSHQDoONnfJoEWCiV5NgfjV0/hO6yZH4JKDmA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F5vIKCEm09RUV3fxuDoWmEW3krl/grnDXUols4NVtSkFrf7Zldb5WJYYJmbKeaT17HrdhK/EyNp6DBeghsWb7BPw4KBZqmjYsuMXjBnhM/YYygKe+aMvvjfatCXAz2S3uMhrIViMmPvwcEimTpYZuRf5OrydlRCzlbL6X1KWR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k95jdctW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b9b1900bso1785410f8f.1
        for <linux-scsi@vger.kernel.org>; Mon, 23 Mar 2026 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774257883; x=1774862683; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=agJiL7CSHQDoONnfJoEWCiV5NgfjV0/hO6yZH4JKDmA=;
        b=k95jdctWO7wdLvPVv8y/yOOxkuzIgcI/KhriKZd+fSQxAKIWgHIK2irvTRdqie3Y5V
         N8qMYObKv7hCYMSFGdZV49RtvQFFHoYvxPpt7yoklzvctS1eyf6ijzmz4+VAMF16DkmA
         qyTe+4RTOtbhb2fx9xnqc1RJ7cB7+cZRFKpk2qbDYVaqyESnj2AkhuHjM5MaTyr4Asyp
         fQ3M9q5NCKII5qNAF9LIhn+yf5jzY99LqpSYowmX6bRj+ejvNVYMbWIMP1PbmZyCAKFr
         jtC/RUED9iZLVRgCnpkfP1KiCusoJlzhO4lgfbABaOOUTb51npfF16uiuFHwdjBnPluf
         /rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774257883; x=1774862683;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agJiL7CSHQDoONnfJoEWCiV5NgfjV0/hO6yZH4JKDmA=;
        b=fqTzN/IfbAIH53aryvn/jTKi71AJ0X8YgOMGTJdrJzCK0RbvUapWyQrpApHJPMG7X+
         hEE7J3wLuLWbQ9/qm2t2v/Y78Qbs9J3xI2WMQYUdeHl/vRnEvI31DOXbd4tMqncpq4XY
         +Jpj5qOtLcEeWTMP33j19d5jfuIl5I59Kfx77zuO78s/zqogKn7yPvszMxEvmbhhhh53
         0nw+pDrAx1McH6ddJl29hZSwgE/CaOq6RsQpef21i9oc6pqNsGEMvRXY19E72nMSnujE
         14I9M31L2bq+nazmQqhlac/PqZz36bKR9yszqvyoSJTl7TpLTr8JVxQvDUk+k9oWKw3+
         2Yvg==
X-Gm-Message-State: AOJu0Ywv5kGHLPhkxf5970YyMftvvLxm52vCZGhBZisipHP1CbLTMLQY
	oKA+SEMtaf0Tu+etzH54dp+UEagy292DvJY8JhlU1woK4NMypFfLJb5C
X-Gm-Gg: ATEYQzzpYRyxPE53IO8iJXS8f2bmW4JOjZgUHB14XGAsnE4fcvFvK55bary03Ekrf2r
	DHjFAVXX7F2Rsmn76QWIHfkMilqUxJSwuMP5a1udcEz+G30yYzyOYM1mCLiknsBbn6DIiA8O/dU
	VEyETJtHQFajlTHoJ7hOebPmzBiglvZATR7+N/4CHrjxb2O+GJwGkBFIBJn8gr5DO2V/+HjmJrU
	MGYoDc2S5ioEWNCGqlUdiUSvvKRuU+6vUotlA3XXP07URvhBClcgLfb6rEqpBKyIEUd9Bky4hxq
	7/NlwWXqTr0XMFjXeEBZQW9G3La3nelNb7L42Oq/U7EiPmRVTJWP/tms5l19LR+84AB9RCq3YfH
	eXpaQRzoGOVsbovuHA3n1cR6LZYgxdrk4tP6pfaQzelzmFzsODN2IQgO+AiJBkhqUmgm5QzqwRG
	4OsssjuyCXv7gwE7SPWfbuvsSL7Q==
X-Received: by 2002:a05:6000:2486:b0:43b:4e01:4aab with SMTP id ffacd0b85a97d-43b642812a5mr17199047f8f.37.1774257883326;
        Mon, 23 Mar 2026 02:24:43 -0700 (PDT)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64711f58sm28577645f8f.29.2026.03.23.02.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:24:42 -0700 (PDT)
Message-ID: <f7d9413f087b0d2c38ad9a6433d9d4237bc80b72.camel@gmail.com>
Subject: Re: [PATCH v4 11/12] scsi: ufs: ufs-qcom: Implement vops
 apply_tx_eqtr_settings()
From: Bean Huo <huobean@gmail.com>
To: Can Guo <can.guo@oss.qualcomm.com>, avri.altman@wdc.com,
 bvanassche@acm.org,  beanhuo@micron.com, peter.wang@mediatek.com,
 martin.petersen@oracle.com,  mani@kernel.org
Cc: linux-scsi@vger.kernel.org, "James E.J. Bottomley"
	 <James.Bottomley@HansenPartnership.com>, "open list:UNIVERSAL FLASH
	STORAGE HOST CONTROLLER DRIVER..."
	 <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Date: Mon, 23 Mar 2026 10:24:40 +0100
In-Reply-To: <20260321031021.1722459-12-can.guo@oss.qualcomm.com>
References: <20260321031021.1722459-1-can.guo@oss.qualcomm.com>
	 <20260321031021.1722459-12-can.guo@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-22397-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huobean@gmail.com,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,micron.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFEF52EF0A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-20 at 20:10 -0700, Can Guo wrote:
> On some platforms, when Host Software triggers TX Equalization Training,
> HW does not take TX EQTR settings programmed in PA_TxEQTRSetting, instead
> HW takes TX EQTR settings from PA_TxEQG1Setting. Implement vops
> apply_tx_eqtr_setting() to work around it by programming TX EQTR settings
> to PA_TxEQG1Setting during TX EQTR procedure.
>=20
> Signed-off-by: Can Guo <can.guo@oss.qualcomm.com>

Reviewed-by: Bean Huo <beanhuo@micron.com>

