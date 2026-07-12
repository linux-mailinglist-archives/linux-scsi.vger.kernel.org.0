Return-Path: <linux-scsi+bounces-26019-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +cygMtbeU2r9fgMAu9opvQ
	(envelope-from <linux-scsi+bounces-26019-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Jul 2026 20:37:10 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15772745A4A
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Jul 2026 20:37:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b="BhpJ7ME/";
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26019-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26019-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 572173002B37
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Jul 2026 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166F3B14C1;
	Sun, 12 Jul 2026 18:37:08 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDEF370AE5;
	Sun, 12 Jul 2026 18:37:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783881428; cv=pass; b=aUKZBft/IbleuIGbMBnRj9d5KbxvQvArCKGZMBAHVwmrJt7ANGmFVfwFUQSqftaW3lpE2tVZcSU6SATgpoU7UB0HoxgLEg2NExkBqmL8TgoSQxpk7HhgWEe9TosociD6VRXJErA7JYzgVE6+QFVlwPN2Z3uppXJxLYu/WDqkz+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783881428; c=relaxed/simple;
	bh=XxBxbZu5lnTAIvACjUhvaFLeD1hcP4TsWny4YYJvo/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lxx4eFhnIg4GTNKq0EmInybBDpnEItUPOmUbQbW7qqk6sTC5UYQs12VuZOIGR9lPp50S+xbjdfStDZ1X5Oe7qJC39p3QQdut8zQhjQffk9uVNhUTZ1bQAcVvCenNpwsKPEkCczgAtcUiqDXIKImxRr9X5hUVZA9N70R+y/x71P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=BhpJ7ME/; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1783881397; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=c2hOA+1Or863rpoI5x+VaEqd4GCi8wfmz4iQkxsbFOaqNbEaWoTsbW6OCtqvtZd6r+nRIXiB1pStJLqz24dg32zc4r6KPwunBLW4C5rB3L1Wc5pzC/7zFlsY/ITauc9JmvkD8mwb7jWtpeAyuepvzJ6c/j6pFPigE0eOIRGpsfg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783881397; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XxBxbZu5lnTAIvACjUhvaFLeD1hcP4TsWny4YYJvo/U=; 
	b=Ku64k6DkJ+52L2y5u9ajIUytXtZN36yKCVr/hTODIT/AQTlpnHBTrDWi5piIcKn3ufWado27sbA94uUSTYp1SezqosnKADtIZB5x2LCqnC3/Y9+tB5/f+th7mDj340LSwtfG/wGqy6tnaOj56OBrJax4/i4EJDyC2+BLKsI1vYo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783881397;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XxBxbZu5lnTAIvACjUhvaFLeD1hcP4TsWny4YYJvo/U=;
	b=BhpJ7ME/jE2z95Pb9fSxy4E4K32YtnaEgp6qFLBU4aD5UkAkhjmEYxqZz5Ab4hdb
	U5jMBJRDL0LwopJdWYW7YOY2KmdXiOAJvI5LtLcOCk9nckCb1rz4I6xwuOM+W/9096l
	dnM2KVLYFq1EPjd6TPjh6BgF1lZLWXeuBOP0/0Kw=
Received: by mx.zoho.eu with SMTPS id 1783881393130550.7142939959992;
	Sun, 12 Jul 2026 20:36:33 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: bvanassche@acm.org
Cc: dlemoal@kernel.org,
	martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	shinichiro.kawasaki@wdc.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scsi: scsi_debug: fix REPORT ZONES alloc_len underflow OOB write
Date: Sun, 12 Jul 2026 20:36:29 +0200
Message-ID: <20260712183629.83851-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <512639c6-3f18-4577-bc4f-7aa8b7e1caf4@acm.org>
References: <512639c6-3f18-4577-bc4f-7aa8b7e1caf4@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[auditcode.ai,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[auditcode.ai:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-26019-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bvanassche@acm.org,m:dlemoal@kernel.org,m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:shinichiro.kawasaki@wdc.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[security@auditcode.ai,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@auditcode.ai,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,auditcode.ai:from_mime,auditcode.ai:dkim,auditcode.ai:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15772745A4A

On 7/10/26, Bart Van Assche wrote:
> Ibrahim, do you plan to address this finding?

Yes -- addressed in v4, which I will send shortly. The v3 ALIGN() can
round an alloc_len near U32_MAX up to 0x100000000, and on 32-bit that
4 GB arr_len truncates to 0 in kzalloc()'s size_t, returning
ZERO_SIZE_PTR and slipping past the !arr check as the bot noted.

v4 clamps rep_max_zones to devip->nr_zones, so arr_len is bounded by
the real zone count and can never reach 0x100000000 or truncate on
32-bit. The descriptor loop already stops at sdebug_capacity, so the
clamp does not change any report -- it is purely an additive bound, and
Damien's ALIGN sizing is untouched.

Thanks for catching the 32-bit corner.

Ibrahim

