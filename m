Return-Path: <linux-scsi+bounces-24473-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +anFG1x/ImpYYwEAu9opvQ
	(envelope-from <linux-scsi+bounces-24473-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 09:48:44 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AC56461E8
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 09:48:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24473-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24473-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 125A8303BB3E
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2026 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1065447A0D8;
	Fri,  5 Jun 2026 07:30:50 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E14611E1
	for <linux-scsi@vger.kernel.org>; Fri,  5 Jun 2026 07:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644649; cv=none; b=QRfA++4nVJmblyJEv95eY5PBI0H0p4Vle/n21QuAZYGEbI4yHGuC8kL7JVKD9SFTB2m6LeluFyO/oEHuLC2JStTeO1JKfpFvbNVPpwXvOq3cquqs421zOO6CKbKtd2zlyCPXhg1PGghNzUYaXc5W6QSlV132Z9Bo3WwGVOQqgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644649; c=relaxed/simple;
	bh=5W/tWie+s0GyiFfiVzYnA5c+lJxiUZ1i+gzNpq+8JKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7JLbW6nG1mN2UM+1zthAwhTAXNR+Gi6M1Ngpoic1ocDg6+O/eyKCzboiacAQ96xagbr0M4RcjfVKAupSuGQ+JibQmFNfuw+PX3DtxeRBRpy28B956X+eBCrQQzgjiuntgcsse9ltI/YCYb+koEidhbyUYsl6VCSjyalzkFexpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59d4aa96ef2so1156696e0c.1
        for <linux-scsi@vger.kernel.org>; Fri, 05 Jun 2026 00:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780644647; x=1781249447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJPTFXFfEVfaClOO5icEXfzsJcEhxZLVJwj7hX3l3SM=;
        b=GvANOyHdM4HYILkLDhd3nf5VF/gLksSb6NOeYkLwA+F5wXDbnCfIS+mDFstJGgmHxq
         0a1EdfXNXhjie/x49g4gw5br6pmfSF77NEOU+tbfUI0oR/ilYmQSfyLz1Fbms34s1oe5
         zH7ydEixqABU/lmpejNPqm8cl2bAIl7/HLPGawTbPeZO4kW81/qWQD06cfPGba4+eDmR
         MrXNI7KQMFZWpSV+Asy1GphW9NjH/MLwsKjLGYXr/WYn3EAxZKxWEOzhaAP+nPm6FigW
         pCnfrW5wGL5Pb7nHyyheFOvCVWZkePOYPt2TFRpsbBiF+FMq+2I0qRDrjNnpIiZk8ptr
         RiRw==
X-Forwarded-Encrypted: i=1; AFNElJ/qlhZIX95Cu6lUAEViYRMvLchiD7y6OTy4S6yVNRoZVOkHjyyZXONLiRVSCT93M4soMqD1rrG+13FY@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpz+BL2OCt52npr4zm7vKRMXwMXKJlJ7ZdkXwten0ftGRtwWM
	hwvrhJgXJjmN6+I57SQi1mDIAULMpLZs0yLZy0tdRxtthGErEowAl1kfRZxxpQ7KY2k=
X-Gm-Gg: Acq92OFLUCx4dwItODuxjkI7XodPKmuK6iAQMrbc9S2CC4TEtFPBZNprrBVH+2VX+tm
	QAD2Wy+3RM4OJSNs0XzuCjIM5i3LeANEEUHMIsu5OeqMghn+kpr1B71932s2y6F+Fkso7PoLBE8
	Gx38t0Yj2lBsl3dYPAXK1HHDR+/2rJTqDxE62Mr4Pc3Y4WxKhWTloUiL4pc4gObD9SwG1/imxYX
	yBAjR0H4YDq0X8hES0TkQVBu/Ube+sMTKwQSxqup+7QpCgLwGzlF4O6jc2NyRwy+lHScEsvGSjS
	UcdZfE8u4xzvoCYEM5y2JWw56iH2BLpXWbOvH3tTZ8YyugBDBOx33DtGpwr3tX0z2q3qiT12qsG
	arQL8zRc6coSTeA0kuGEYzS2w7V36s+m+LfwVDp03mCQJ5ezsetwIoVzyV3fvE0zvwQx0lmhBnb
	bjej8eyrzddyGaQKdINCkoLLhPoXbuZeFSW4nDrPR0A4z5nv97yW+9HVwK/YhCNWKeN4saa9c=
X-Received: by 2002:a05:6122:e14e:b0:5a0:3d17:f939 with SMTP id 71dfb90a1353d-5ac5291a586mr1116284e0c.9.1780644647585;
        Fri, 05 Jun 2026 00:30:47 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dcc2ecbesm6612957e0c.13.2026.06.05.00.30.46
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 00:30:46 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-963a7e48493so1199821241.1
        for <linux-scsi@vger.kernel.org>; Fri, 05 Jun 2026 00:30:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/3JAHDeGrN3aWpYtwrlX/IP38uG7r2Qj/m0GIjUZHWghyu6nbJJ+NfFrTVM489qyvMpEiBxCNdcSGz@vger.kernel.org
X-Received: by 2002:a05:6102:cc8:b0:62f:3abe:907f with SMTP id
 ada2fe7eead31-6feed1adbffmr1189675137.4.1780644646130; Fri, 05 Jun 2026
 00:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
 <20260604-remove-pktcdvd-references-v3-1-e2f06fb4eef4@gmail.com> <88d9bb41-e51d-4b71-a6d9-f1b79eccd496@acm.org>
In-Reply-To: <88d9bb41-e51d-4b71-a6d9-f1b79eccd496@acm.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jun 2026 09:30:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVhjYBhKUPzx-FAKWAAkUwcpYh0v2V5w64OMJtREZr4PQ@mail.gmail.com>
X-Gm-Features: AVVi8CdzPUN0PjO13sCwZaAxIjLcvwA5tXzyJ1zGjjn5YbgvhAb6LM_UbfPQhv4
Message-ID: <CAMuHMdVhjYBhKUPzx-FAKWAAkUwcpYh0v2V5w64OMJtREZr4PQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] scsi: core: Remove remaining reference to the
 pktcdvd driver
To: Bart Van Assche <bvanassche@acm.org>
Cc: Catalin Iacob <iacobcatalin@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24473-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bvanassche@acm.org,m:iacobcatalin@gmail.com,m:tsbogend@alpha.franken.de,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:dalias@libc.org,m:glaubitz@physik.fu-berlin.de,m:davem@davemloft.net,m:andreas@gaisler.com,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:axboe@kernel.dk,m:ysato@users.sourceforge.jp,m:linux-mips@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-sh@vger.kernel.org,m:sparclinux@vger.kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,linux-scsi@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,alpha.franken.de,linux.ibm.com,ellerman.id.au,kernel.org,libc.org,physik.fu-berlin.de,davemloft.net,gaisler.com,hansenpartnership.com,oracle.com,kernel.dk,users.sourceforge.jp,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:from_mime,linux-m68k.org:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68AC56461E8

Hoi Bart,

On Thu, 4 Jun 2026 at 18:01, Bart Van Assche <bvanassche@acm.org> wrote:
> On 6/4/26 6:20 AM, Catalin Iacob wrote:
> > Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind an
> > export that is now dead code. Remove it.
> The subject should say something like "Unexport
> scsi_device_from_queue()".

<pedantic>
But that is not what it does: the symbol is never exported, as
CONFIG_CDROM_PKTCDVD_MODULE can never be set?
</pedantic>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

