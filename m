Return-Path: <linux-scsi+bounces-624-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9465E807013
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 13:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF826280CD4
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 12:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DC936B08
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i70/7p8g"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0DED3;
	Wed,  6 Dec 2023 04:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yrd81zGIMcL6sMoWgoNBvb1lXE8kmP7kb3JaHTjBjiI=; b=i70/7p8gIkV7DabBIvmNTAAi7+
	nQJhG3mQpJ00MrnqENybbEfiTaDWNko+AzpuxMCPOO21tBjS0WFOYIu/73z2Z+qZJORN3ZjsZinL0
	35QHXEjJmGVuQ1TmokfqEbSrsJptOKwBnxGohW5qpwGklQ88Aokp1xlxo71NHRkGHJDo28tvX6SAC
	EThPFvOR58I2hCHyYo+1RCS+aNNNSLve8oIZBfgJNvHtLNGMLNoH5AS0gvtLh4hyHRdYfPWDYDv7h
	9ngfQVui94MSlUlhFn+bJv5TC7w4w1u7aLJ05kr+/a67eU+XFLPRegZdqfOQVEhvoD4NAQYNCqwhJ
	QoVUoQ0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAqiY-00ADob-2i;
	Wed, 06 Dec 2023 12:09:30 +0000
Date: Wed, 6 Dec 2023 04:09:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, quic_cang@quicinc.com,
	Manish Pandey <quic_mapa@quicinc.com>
Subject: Re: [PATCH V1] scsi: ufs: core: store min and max clk freq from OPP
 table
Message-ID: <ZXBkeqyoA1E3bznx@infradead.org>
References: <20231206053628.32169-1-quic_nitirawa@quicinc.com>
 <20231206075447.GA4954@thinkpad>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206075447.GA4954@thinkpad>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 06, 2023 at 01:24:47PM +0530, Manivannan Sadhasivam wrote:
> But these values are used by the vendor host drivers internally for controller
> configuration. When the OPP support is enabled in devicetree, these values will

There is no such thing as a "vendor" driver.


