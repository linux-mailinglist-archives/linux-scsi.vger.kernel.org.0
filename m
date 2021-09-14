Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C8540A7A5
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Sep 2021 09:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbhINHhc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Sep 2021 03:37:32 -0400
Received: from verein.lst.de ([213.95.11.211]:58933 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241154AbhINHg5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 14 Sep 2021 03:36:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 13B6D67373; Tue, 14 Sep 2021 09:35:38 +0200 (CEST)
Date:   Tue, 14 Sep 2021 09:35:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, hare@suse.de, hch@lst.de,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v2] scsi: Delete scsi_{get,free}_host_dev()
Message-ID: <20210914073537.GA580@lst.de>
References: <1631528047-30150-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631528047-30150-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
