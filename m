Return-Path: <linux-scsi+bounces-626-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED7807016
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 13:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FC6281471
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB636AFF
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yqoCcLpp"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9671BD;
	Wed,  6 Dec 2023 04:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=leiOy4pfs2M7Gc5q5SIIOyBYtiFRTNEgwnrs/Ad5pAc=; b=yqoCcLppPJTBsAE3D8LSk+hlFa
	XTvoZx7fDjty1f96GFi7c/aSmmdqS+CIZrp0j2gds1FCZnpK69YVk6Tptc/0HF1rWFrK/6S8LCmRE
	LjU6+Jcmw3kTjRcp40nn+dfetAavwOrIk2xn30qxw7a6Hx0RMIwLeRGNWu4CYdE75QwaiqoZXYYYw
	evYhOB58/PP6Af/LOUoqCjSPGjxkiVrH2ERem72TqvXs601wg7yGzxkEQLg2wafHglC130cXvPhVY
	ZjxRvag9C31bvyV3CbE7FIALTOlVJpWSeAEMhcrCuC3pmGMR6oq3/JU6kOl02AFTbtd6z8ASQpv0b
	8ubIIDUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAqj9-00ADve-2q;
	Wed, 06 Dec 2023 12:10:07 +0000
Date: Wed, 6 Dec 2023 04:10:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
	Manish Pandey <quic_mapa@quicinc.com>
Subject: Re: [PATCH V2] scsi: ufs: core: store min and max clk freq from OPP
 table
Message-ID: <ZXBkn/VkkTSDtknP@infradead.org>
References: <20231206114659.13009-1-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206114659.13009-1-quic_nitirawa@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 06, 2023 at 05:16:59PM +0530, Nitin Rawat wrote:
> But these values are used by the vendor host drivers internally for

There is no such thing as a "vendor" driver.  Please be precise with
your wording.


