Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 270764C77C
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 08:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfFTG24 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 02:28:56 -0400
Received: from verein.lst.de ([213.95.11.211]:58021 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfFTG24 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 Jun 2019 02:28:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B7A4268B05; Thu, 20 Jun 2019 08:28:26 +0200 (CEST)
Date:   Thu, 20 Jun 2019 08:28:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] sd_zbc: Fix report zones buffer allocation
Message-ID: <20190620062826.GC20765@lst.de>
References: <20190620034812.3254-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620034812.3254-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This looks like what we discussed last week, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
