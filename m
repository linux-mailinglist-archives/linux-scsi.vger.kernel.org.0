Return-Path: <linux-scsi+bounces-23906-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBA6Oy0QDGoZVQUAu9opvQ
	(envelope-from <linux-scsi+bounces-23906-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 09:24:29 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 673FE578FCB
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 09:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81DB53040D84
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308603D0919;
	Tue, 19 May 2026 07:21:33 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11381A704B;
	Tue, 19 May 2026 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175293; cv=none; b=VG0iBCOAbcqiuAY8XZir0Ciu7BG+o7XNyly/XmKerLciB94h4oyEwc4ll4zqe8TveA7XGU7A/Rasq9R5W8RZbuOYFvkLaTM2TOE+zTeQFRoAby0ya0Z6p5VXVeneju2eS31f1DpyWZR3Ergc+bmc4BtHaT4kLu1vmyC3uVzjElw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175293; c=relaxed/simple;
	bh=Xy4Sp/cEI/qpQjCtRRhjD+5Y7uj1UIAgmmQSsXK/NBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVmxLZcpmGT8J5Y0uAfJ0STDf+jb4jLmOC8V8IEFs0SiBx3lG/RfL55Vpobj610M4zTJYAe80RPdw8mnkGc5xJLNk2pJfuhHB9lU7oAH7qoF8Lu6LDyjvMJIFSOPHYi93x9Q+lCIKZOIDTv57G9tejaoUYZdynNDwCsdKp+BdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD8E768C4E; Tue, 19 May 2026 09:21:26 +0200 (CEST)
Date: Tue, 19 May 2026 09:21:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Shyam Sundar <ssundar@marvell.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_transport_fc: widen FPIN pname walker
 counter to u32
Message-ID: <20260519072126.GA10436@lst.de>
References: <20260518140945.2751273-1-michael.bommarito@gmail.com> <20260518140945.2751273-2-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518140945.2751273-2-michael.bommarito@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23906-lists,linux-scsi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lst.de:mid]
X-Rspamd-Queue-Id: 673FE578FCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +	if (pname_count > max_count)
> +		pname_count = max_count;

Use min/min_t here?

> +	for (i = 0; i < pname_count; i++) {
> +		wwpn = be64_to_cpu(li_desc->pname_list[i]);
> +		rport = fc_find_rport_by_wwpn(shost, wwpn);
> +		if (rport &&
> +		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
> +		    rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
> +			if (rport == attach_rport)
> +				continue;
> +			fc_li_stats_update(event_type,
> +					   &rport->fpin_stats);
>  		}

> +	pname_count = be32_to_cpu(pc_desc->pname_count);
> +	desc_len = be32_to_cpu(pc_desc->desc_len);
> +	if (desc_len < sizeof(*pc_desc) - FC_TLV_DESC_HDR_SZ)
> +		max_count = 0;
> +	else
> +		max_count = (desc_len -
> +			     (sizeof(*pc_desc) - FC_TLV_DESC_HDR_SZ)) /
> +			    sizeof(pc_desc->pname_list[0]);
> +	if (pname_count > max_count)
> +		pname_count = max_count;
> +
> +	for (i = 0; i < pname_count; i++) {
> +		wwpn = be64_to_cpu(pc_desc->pname_list[i]);
> +		rport = fc_find_rport_by_wwpn(shost, wwpn);
> +		if (rport &&
> +		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
> +		     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
> +			if (rport == attach_rport)
> +				continue;
> +			fc_cn_stats_update(event_type,
> +					   &rport->fpin_stats);
>  		}
>  	}

Am I missing something or is this code entirely duplicate except
for the different stats updates helper?  Maybe use the chance
to factor it into a common helper in a follow on patch?


