Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68C63EC131
	for <lists+linux-scsi@lfdr.de>; Sat, 14 Aug 2021 09:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbhHNHkb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 14 Aug 2021 03:40:31 -0400
Received: from verein.lst.de ([213.95.11.211]:49498 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhHNHkb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 14 Aug 2021 03:40:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 503A668AFE; Sat, 14 Aug 2021 09:40:01 +0200 (CEST)
Date:   Sat, 14 Aug 2021 09:40:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.de, hch@lst.de, bvanassche@acm.org
Subject: Re: [PATCH 0/3] Remove scsi_cmnd.tag
Message-ID: <20210814074000.GB21536@lst.de>
References: <1628862553-179450-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628862553-179450-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The whole series looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
