Return-Path: <linux-scsi+bounces-23306-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id inIGGIhg7WlbigAAu9opvQ
	(envelope-from <linux-scsi+bounces-23306-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sun, 26 Apr 2026 02:47:04 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 964E6468814
	for <lists+linux-scsi@lfdr.de>; Sun, 26 Apr 2026 02:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE9A83002B13
	for <lists+linux-scsi@lfdr.de>; Sun, 26 Apr 2026 00:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488F1DF736;
	Sun, 26 Apr 2026 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rlRFL6HT"
X-Original-To: linux-scsi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941841643B;
	Sun, 26 Apr 2026 00:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777164420; cv=none; b=rrM/2sKfMzCRLq/KmWARU+kxbQVm0sHQueG8QjjVD5HwLm1vbUivMIi/xj7E9EZb/KTc6jDEH9vU9hL3HlKlIfp0IPqX3LswOmx7TRUQeEmI/jrO4HJzPY3HGc7FAqav0i+Rcs9EnOPmLJ/LxQrD/2dr3hPE5PssA1tyNdJocNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777164420; c=relaxed/simple;
	bh=wivrWUKBaG9wBfqHbKGTh0VM6/RwGrg3NL5+VqrkrwI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qfao/gpQJhyQbiy4FTbKAzfirEqzj2GhkArM80lzlVhkaBVFmCEPBaL3RAVZjMh+0q0LnMTpvyS+JrC66+XcSqaFkL0QCQTmEJLclwxf5wfiej14GwyAQov9ZA7bbtPK0RNvuTRrFFHKTqi4aXsX19OH3446oVd5uVlj6prkVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rlRFL6HT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Zy2DJrRJGdFUsSTr714o7ATNF+h3r8jGyotdyT2gNt0=; b=rlRFL6HTN6Uikbhx9EZ/OEyagX
	wyGrCyVHAda/E5rVz1TLqfgZKhtonzmjqC2kLwejrmv2h9kN4l0sK3AXW03khsy/p6A1ZBXMUP38U
	6nN7TnGPbKWp4NrFebCFw26IOvQNc5XZoQhsrAbhxvjZuL2JNfLnWHW/keOxGovt+vH4T1Q7p3qck
	zzImYw1jm9AZF/7YGYcCRUMNDPtokdd28BAFrrVAt+qgbjnV4itZemlJPiCqryxDln0uBevIeaMl+
	IWZLqCBSIukbzQ8SVDIq5Clb8tgo1WZKfxR22JmsxuhgsLkxn+qpEWiP+2OJOBQT8zJjmOIK4GDCK
	q8N0TYLg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGne7-0000000HRp9-3JPy;
	Sun, 26 Apr 2026 00:46:51 +0000
Date: Sun, 26 Apr 2026 01:46:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Subject: [LSF/MM/BPF] Running BOF
Message-ID: <ae1gegHjBsgiMdXY@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 964E6468814
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23306-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,casper.infradead.org:mid,garmin.com:url,greatruns.com:url]

I'm going to go for a run each morning.  If you want to come
with me, meet in the Esplanade Zagreb hotel lobby around 6:45am
(this should get us back in plenty of time to get to breakfast).
I've plotted three routes, all based on routes described in
https://greatruns.com/location/zagreb-croatia/

Monday: https://connect.garmin.com/modern/course/453744315
Tuesday: https://connect.garmin.com/modern/course/453746189
Wednesday: https://connect.garmin.com/modern/course/453747068


