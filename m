Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592921F6159
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2020 07:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgFKFnN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jun 2020 01:43:13 -0400
Received: from verein.lst.de ([213.95.11.211]:49316 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgFKFnN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Jun 2020 01:43:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D7C266736F; Thu, 11 Jun 2020 07:43:11 +0200 (CEST)
Date:   Thu, 11 Jun 2020 07:43:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     martin.petersen@oracle.com
Cc:     john.garry@huawei.com, brking@us.ibm.com,
        jinpu.wang@cloud.ionos.com, linux-scsi@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] scsi: wire up ata_scsi_dma_need_drain for SAS HBA
 drivers
Message-ID: <20200611054311.GA3607@lst.de>
References: <20200610064540.269738-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610064540.269738-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

I'll need to do a v2 as this causes undefined references when libata
isn't enabled.
