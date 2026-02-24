Return-Path: <linux-scsi+bounces-21005-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBkLDBB1nWmAQAQAu9opvQ
	(envelope-from <linux-scsi+bounces-21005-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 10:53:20 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C797F184F73
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 10:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ADE53047FB7
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCFB372B3E;
	Tue, 24 Feb 2026 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PazVMNIV"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA736D50A;
	Tue, 24 Feb 2026 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926794; cv=none; b=tvk/Jao8jD1+fGDuQr64HGtcaksNL36lLK0u41actddpogTVdztmVlg1lwTpqKZisiinINRs9hAjJROGDcMcE074eKP80W7NuCnBrI2L/x8djoUTiPCC9Z+hxq/2ceh4I9hRZ3ze4ahenHu8H2hjQogOMz4Ui46MADSptPFpcgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926794; c=relaxed/simple;
	bh=dqLOm0PM7kcvpjftBJlRGEhwi4F/wqsNJqUoHigpCYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWWEi8Pw+GY2gP78PQxtTtIA9aAFUPE2t4jl7YXVTiQXuavJUlxkN7KmME4eRFlbGhnLlmQqcNGy5scnMe6koFxa6hyCq8UDHSSem4B4LS3rZXC3JXqJBPf30hVsdA+QulW2G5iHfVzRnwT1u1TrFFCoDov2nuF1rmTOeoFccrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PazVMNIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02DEC116D0;
	Tue, 24 Feb 2026 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771926794;
	bh=dqLOm0PM7kcvpjftBJlRGEhwi4F/wqsNJqUoHigpCYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PazVMNIVrnDgSPiJ3FUli5BCxqck3xy49vEaki781IWSysnCstNXLDJHfT2CY7mxz
	 6UZAKfjuBBy6v9NZDDMFZyz6nezomxLaLhOCC4hz+BReH7i7oDebgBVXanCgikIBbC
	 fMYYI6uQlNm7M47ehvrcFq7UfeTFgHPXO3k85TdYP1L3EumeOzBUuUjyo1t7414yc5
	 /aJ7ym+RPxCD+eD8K65j0IFpc9Mv/JCyyA61V7T0jRgGkvPV0eA9t/ifE7Oz4ItytR
	 kK+aUQiaItrgLsWnb1lSuMLdVNFUWM+nel9DKT9ya/IJ8v88xxH1Yo70IKbMsIk7t7
	 1TCDPuCqcTUuA==
Date: Tue, 24 Feb 2026 10:53:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org, lwn@lwn.net
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260224-sangen-aufatmen-06ba16719f33@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <20260119-bagger-desaster-e11c27458c49@brauner>
 <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner>
 <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21005-lists,linux-scsi=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C797F184F73
X-Rspamd-Action: no action

> Don't forget to pester^wask^wremind your respective organizations to
> sponsor LSF/MM/BPF 2026! If it helps, you can tell them that we're
> considering renaming it LSF/MM/BPF/AI.

I have just looked at the sponsorship site for LSF/MM/BPF/AI again and
we all really need to go out and go steal some of that AI funding money
and funnel it into one of the conferences that really drives development
of the operating system that drives the compute for all of this.

Please go and remind your organizations to sponsor. They should know how
to get in touch with the Linux Foundation. Just going by the sponsorship
page we're missing a bunch of large organizations that we would
appreciate if they decided to pitch in. :)

Christian

