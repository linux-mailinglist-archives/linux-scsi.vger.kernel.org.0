Return-Path: <linux-scsi+bounces-21166-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACwJIDpgn2lRagQAu9opvQ
	(envelope-from <linux-scsi+bounces-21166-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 21:48:58 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F62219D6F9
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 21:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E036730138F1
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 20:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3E2288C2D;
	Wed, 25 Feb 2026 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UuyHarI+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UuyHarI+"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC5A287517
	for <linux-scsi@vger.kernel.org>; Wed, 25 Feb 2026 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052531; cv=none; b=iJUNPlU7UKZcFYmQyijvYHpwR8IX8Jb32LPK+zKAu8p+XZtOvungj7PdOd91imsnsmbJ4xbwZ4JYLPIxtr2XPwTwMbf6LwFSYuc7IO56gdE5RbA7zgKUKYcZAnVvutfbvSiZfUiS/GFt7VYoh4JkPoDuvMORTuRql2vz2iV2PYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052531; c=relaxed/simple;
	bh=0ySrbreaAVodXkPSDhxsOxjmlAlgEP3exYQFz2ZVN9g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eSfZMc+z2oxn4bW/nw5fi4eCu+8fiyUBqWwjnLWQ7nc2cWJAvJ5+8B7eZ6cyQtE6VBLp6FoDRnhqmFZ4Yxio1m+P370dEbG7/Sp5k3sVUcaGjJ7PNY1Eupxw8C5MNc6TDRa2/9pyB07Ao05W6V7UKb0yyZn2/YWOvhpQa20DTOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UuyHarI+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UuyHarI+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BEFA5BD4B;
	Wed, 25 Feb 2026 20:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772052528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ySrbreaAVodXkPSDhxsOxjmlAlgEP3exYQFz2ZVN9g=;
	b=UuyHarI+JWDAz0w4sxeY/LNGboXI17oreDv/IiZPsawx8Rt3aUcdRzuMPAPayOCOpb/DFe
	zL1jeJO+LxnChjoxp8t+xnzlAOND9uggZF4SyORLK7mEqx8U9KJRGajWaZ06jvtr6qETxZ
	b1OlootZmnPIFk0XU1CvtGnxMSQ9fC8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772052528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ySrbreaAVodXkPSDhxsOxjmlAlgEP3exYQFz2ZVN9g=;
	b=UuyHarI+JWDAz0w4sxeY/LNGboXI17oreDv/IiZPsawx8Rt3aUcdRzuMPAPayOCOpb/DFe
	zL1jeJO+LxnChjoxp8t+xnzlAOND9uggZF4SyORLK7mEqx8U9KJRGajWaZ06jvtr6qETxZ
	b1OlootZmnPIFk0XU1CvtGnxMSQ9fC8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5AEE3EA65;
	Wed, 25 Feb 2026 20:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AnpYMi9gn2knYAAAD6G6ig
	(envelope-from <mwilck@suse.com>); Wed, 25 Feb 2026 20:48:47 +0000
Message-ID: <f00d0f30082b3db334638066d3668d43e5a9e495.camel@suse.com>
Subject: Re: linux-scsi project on GitHub & SCSI user space utilities
 maintenance
From: Martin Wilck <mwilck@suse.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Douglas Gilbert
	 <dgilbert@interlog.com>
Cc: linux-scsi@vger.kernel.org, Paul Evans <pevans@redhat.com>, 
 =?UTF-8?Q?Tom=C3=A1=C5=A1_B=C5=BEatek?=	 <tbzatek@redhat.com>, Hannes
 Reinecke <hare@suse.de>, Lee Duncan	 <lduncan@suse.com>, Bart Van Assche
 <bvanassche@acm.org>, Mike Christie	 <michael.christie@oracle.com>, James
 Bottomley	 <James.Bottomley@HansenPartnership.com>, Chris Hofstaedtler
 <ze1ha@debian.org>,  Xose Vazquez Perez <xose.vazquez@gmail.com>, Daniel
 Horak <dhorak@redhat.com>
Date: Wed, 25 Feb 2026 21:48:47 +0100
In-Reply-To: <bddb92c1b37685ddc331efacdc2afdc9b39684ec.camel@suse.com>
References: <e99744196d8a0ca2bffec1d13109eea071c99096.camel@suse.com>
		 <yq1pl5t5wlf.fsf@ca-mkp.ca.oracle.com>
	 <bddb92c1b37685ddc331efacdc2afdc9b39684ec.camel@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,suse.de,suse.com,acm.org,oracle.com,HansenPartnership.com,debian.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-21166-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mwilck@suse.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 9F62219D6F9
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 10:49 +0100, Martin Wilck wrote:


> Perhaps we can use this email
> thread to get everyone on the same page.

By some funny coincidence, it has happened that Doug returned to his
sg3_utils GitHub repository just the other day [1].=C2=A0I swear that I had
no idea that this was going to happen when I started this thread.

So the main point of this thread is obsolete now. I've added Doug to
the recipient list, in case he wants to chime in.

Anyway, welcome back Doug!

Thanks
Martin

[1] https://github.com/doug-gilbert/lsscsi/issues/6

