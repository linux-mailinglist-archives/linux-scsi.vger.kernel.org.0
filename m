Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA492486C8
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Aug 2020 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHROL2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Aug 2020 10:11:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:42382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHROL1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Aug 2020 10:11:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF55CAC12;
        Tue, 18 Aug 2020 14:11:51 +0000 (UTC)
Date:   Tue, 18 Aug 2020 16:11:25 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Wu Bo <wubo40@huawei.com>
Cc:     <martin.petersen@oracle.com>, <michael.christie@oracle.com>,
        <bvanassche@acm.org>, <sudhakar.panneerselvam@oracle.com>,
        <mlombard@redhat.com>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH] target:iscsi-target:Fix null pointer access while
 logout the iscsi session
Message-ID: <20200818161125.359383ef@suse.de>
In-Reply-To: <1597749370-631500-1-git-send-email-wubo40@huawei.com>
References: <1597749370-631500-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

On Tue, 18 Aug 2020 19:16:10 +0800, Wu Bo wrote:

> From: Wu Bo <wubo40@huawei.com>
> 
> When I use fio to test the iscsi volumes and logout of the iscsi session
> at the same time, the following crash occurs:

The change looks reasonable here, but I'd like get a reproducer for it.
I've attempted something via:
https://github.com/ddiss/libiscsi/tree/async_logout_during_write
(run iscsi-test-cu --test iSCSI.iSCSITMF.LogoutDuringIOAsync)

Do you have any ideas why I'm not able to hit this oops?

Thanks, David
