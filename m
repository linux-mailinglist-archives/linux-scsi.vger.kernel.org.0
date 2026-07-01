Return-Path: <linux-scsi+bounces-25419-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S42OIuQNRWr15woAu9opvQ
	(envelope-from <linux-scsi+bounces-25419-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 14:53:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F676EDA01
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 14:53:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ZTe7NCnn;
	dkim=pass header.d=redhat.com header.s=google header.b=m+r4fcpz;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25419-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25419-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91F4C326CB72
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B4448BD29;
	Wed,  1 Jul 2026 12:28:11 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3648167B
	for <linux-scsi@vger.kernel.org>; Wed,  1 Jul 2026 12:28:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908891; cv=pass; b=doCi+49qN3cbp1QiIO1AImw2NEUj47fpe/f8C8tJwWNyRI3XB0ppV5m8udgQoee0vcRY5qVyBXuj7ps6ein4xvOdLCi5c3h/ngNsNcKwB7WkQ5AqLhBA9Hgv8Qryl4BcH7S2Rqij4EGiVDtgqqEqES92QiByRC1QG1bG1AnTnfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908891; c=relaxed/simple;
	bh=8GY8VotGESxfEgt1FWvDvcexvdvgW3JR6+IWhrgOhMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I621luxE6YC4Kk86Xr6E8O0uAGth2a2drSLRKVMbDXgbpoRntjzhjNG5m6iV2gS8PrCxCVZxMayE+lGWLDNq0NZ/FZn/frgYiNCJ3avmsxYQPHdeRNjKKoqqkeHb7eB4HdoezAhKC2ofZMD5kWIB6/PLc/NMdvasAiJwFfv3NVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTe7NCnn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m+r4fcpz; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782908888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAEKnZyBUpDEXcuKl2IGPPrLceMJc14RqaffxTmnEpA=;
	b=ZTe7NCnnUyDWDpPKU9IETXD1a1hqAhw38w1SXifzg/Kvscj46BQcVADhV/5VGUuH0mGlDZ
	YuBJfsY3K3wI9XRzNT26MrC3DB2r0AWRx5VnktqdKB3Et7TX17nQzTt3Ao62lj0A69Rmp5
	EZ/kSXxB3vXb7snSaoomLm3siNikr8A=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-O9gls0gjNsas8lMdOdeF1Q-1; Wed, 01 Jul 2026 08:28:05 -0400
X-MC-Unique: O9gls0gjNsas8lMdOdeF1Q-1
X-Mimecast-MFC-AGG-ID: O9gls0gjNsas8lMdOdeF1Q_1782908885
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-664cdeab2f2so1410572d50.3
        for <linux-scsi@vger.kernel.org>; Wed, 01 Jul 2026 05:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782908885; cv=none;
        d=google.com; s=arc-20260327;
        b=dqotTlucvh/LqDnTvSRLkXBuR+ea/7J0waWzO8o8UCr96kIDHYwG6x7bNszejiNpjr
         HJTFFANri1MAL2leL9+0DgLmBBnmoxVMhe1C5dLCRdG9+39uGowBm9/4Ca8aijcmZBsY
         96tQDPketu288/LWuSLDD2xg8NCtQaHW3G54ftizJwwcIQ/ESKONzG5awMXnsShwbtiM
         24TNncA204fqjaxcs310ZHGfivACAiGU/ODPtPx0sJXN5GjlAIkQJmFRwOKH+jJauNm0
         cuVz6XPy1x6k2N+wqIzs2WIFJnxXjwDS3y1slBtNbNk+uDsJbcQsKx8j/a6u2ADP/BNT
         O7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dAEKnZyBUpDEXcuKl2IGPPrLceMJc14RqaffxTmnEpA=;
        fh=owLIoI9W0VsN1YhMghVsP+zVNuKPe6QrjzD2yEZmcxw=;
        b=VXRiGO176kpaqdxy86lwgH1r3ieJPTTSQMy6j8IYLL9kAGuSm55GqM/K+amJlJQHl0
         g3sjO0+N7c+yxX1/KyDI4jPTXpD03wOmS+UKY77tVT5au4KPdHKiYvzYbSeUM28bUlCF
         wGRkMaSUsu3P9x4RQ4oldFPxxvlcReIIcAUUagat1d1S++ggWKsXXf5Ebm5gHkizcI8L
         82PVHIZllAZvNb2WqmXbxugFwblpQOakLC0gIBOwURaoRL3h1wxbtw0yqTCezFnVq2R9
         Tl1HyUGA7K7O5YEOF0bZBeafO1+T+nx01hp1EOIfRMoBjnmm2FOHyg6jaqdJDa1KPq3n
         ZX+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782908885; x=1783513685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAEKnZyBUpDEXcuKl2IGPPrLceMJc14RqaffxTmnEpA=;
        b=m+r4fcpzbRoBMPqrYzfEYJsklakU6C4/3BuXSp44eXeOQyHcXsaBxJU2Y+ZvGdjdVj
         8H+MbZrZce/jUtpOLzSomDB4JGKixNzln8MjElqMvuhS5vBxqZx1O7EB1sJeyfDlQ3YO
         qeJ7UIxx1SDFOIE77tPxdXvyOm4MqZKkBR59S8U1lMzch/D0rYqER0waE42z93gAirYH
         rsPpMDov4oWGbZxfRDc8vELD7x4nryLxE+bCcTmfqE+sSt+2HWnxbCGNkPuYxHxLlxCg
         Xif4aB92ngbn2e7FvqaPlM2AfNobPfI9qfX+55NCsBdKC4PzoYTC9MfPIJsyQkxO/u61
         CDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908885; x=1783513685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dAEKnZyBUpDEXcuKl2IGPPrLceMJc14RqaffxTmnEpA=;
        b=RmvlcV5WU0RtZdBf2DNxpHmgJNRpoWaq62ZKcSUre/ggq5Fvq1yw9RJMsoajSYUxVf
         JaxoZ0TeMGnnDi8CEzI8ydy76K4IPGgP8s8xl808Bfj0rzwVIcTW9dfX/lKp1vxO5yV+
         tEe9sc4Se1JbhCNKr5P7Bb6hmdwn4xemZxfJT+vefmGFpSwJPE5e3QLYGpRh7GpfwaJe
         widehX9RdcPJxtpc7baQP4ma05oWNGiAtPAPFBDy41FYGI0n/bX1nxSXC8OkhbIF82+a
         CQXDJUsmhZ+NimvBhwWwygT6CKlco5KTW6J8ArVPzI2HLhQOQkfqL5cQFcGL6HolO8NR
         Q7jA==
X-Forwarded-Encrypted: i=1; AHgh+RrKnafEatbqhkO989crZiqtdiVVYRu0FxOEgrxm7j8df/zr406g96lqX3vumgJy9pLL5YUHvVvee9Tz@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNGKFt5Fz+pIsODFYozPBn3E1SbJwMDdN5S1ua1l7reh0AKxt
	iHFftqfKOXyV8BnPmk3XycJ6HDg5BFHEhzmFtR2oBMoaerF/25QO3zttvL1d7LF6cEnC1rnQyw7
	5VpXu0csZupuEquFcZZsld7pcvbnVrNc0b3q5cyXyUwv/dWwAH29ubg40CEWH/KE2+q/L6gP9lP
	08/ksW9TP3IggfJMriFR0nTdnzo0vVeHPbiODLYA==
X-Gm-Gg: AfdE7cmWSQE5S9jWxL3w5HbilMfux8qkAeMb8Y3VjIBsfMosiIDPPCt/mwoTA0ICwnV
	SFpi/KzNJgWBNgWcxqY+MlkJ4We3iYiFR4xE32yVdw8hn7KhKThEEZ2A+yV4sVPiHaggcUvFjpJ
	55PEfSBtJd8YBYwBAxQqePSWk86mjXOn8OQdfGaRCAXUcTYJA9tKbO4mDe3IDm8wHXhMH6cLXwv
	62tafTzp4heePPpeFvUXYZUyeXfH++djx4Kg9QevD7HAbRFKw==
X-Received: by 2002:a05:690e:43cd:b0:664:ae68:ca03 with SMTP id 956f58d0204a3-66521bd34c4mr1059032d50.73.1782908884817;
        Wed, 01 Jul 2026 05:28:04 -0700 (PDT)
X-Received: by 2002:a05:690e:43cd:b0:664:ae68:ca03 with SMTP id
 956f58d0204a3-66521bd34c4mr1059014d50.73.1782908884285; Wed, 01 Jul 2026
 05:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629190108.601212-1-vnagare@redhat.com>
In-Reply-To: <20260629190108.601212-1-vnagare@redhat.com>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 1 Jul 2026 08:27:53 -0400
X-Gm-Features: AVVi8CfXGsBzPJ42p935FUncQFibzyB6zzXTpFZSgDEbMKe64X5e0VN_OvMM2LQ
Message-ID: <CAGtn9rkjabS2c8qQaXpJpV9Du4Tehtb_U1p6eGB9Yci3cC5dcA@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: lpfc: Add rport validation in lpfc_dev_loss_tmo_callbk
To: Vaibhav Nagare <nagarevaibhav@gmail.com>
Cc: justin.tee@broadcom.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vaibhav Nagare <vnagare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25419-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nagarevaibhav@gmail.com,m:justin.tee@broadcom.com,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vnagare@redhat.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[emilne@redhat.com,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emilne@redhat.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1F676EDA01

On Mon, Jun 29, 2026 at 3:01=E2=80=AFPM Vaibhav Nagare <nagarevaibhav@gmail=
.com> wrote:
>
>   Fix a kernel NULL pointer dereference in lpfc_dev_loss_tmo_callbk()
>   when ndlp->vport is NULL during FC remote port deletion.
>
>   The crash occurs during fc_rport_final_delete() when the vport has
>   already been cleared on the ndlp structure, but the dev_loss_tmo
>   callback is still invoked.
>
>   The driver already has lpfc_rport_invalid() which validates rport,
>   rdata, ndlp, and vport. The function lpfc_terminate_rport_io() uses
>   this validation, but lpfc_dev_loss_tmo_callbk() does not, leading
>   to a NULL pointer dereference when accessing vport->phba.
>

Yeah but this doesn't really fix the problem.  It may avoid a crash in
this particular place in lpfc_dev_loss_tmo_callbk() but the cause of the
null ndlp->vport pointer is that the lpfc_nodelist object has already
been freed due to an incorrect refcount.  If we return prematurely
the driver is not cleaning up the rport state properly.

Unfortunately it can be difficult to pinpoint the cause of the prematurely
decremented refcount and we have been chasing these problems for
years.

Prior to c6adba150191 ("scsi: lpfc: Rework remote port lock handling")
lpfc_nlp_release() did not set ndlp->vport =3D NULL, among other things
and so the driver typically did not crash but operated with a use-after-fre=
e
and probably did not behave correctly,

-Ewan


