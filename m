Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC04C24F395
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Aug 2020 10:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgHXIEZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Aug 2020 04:04:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:40722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHXIER (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Aug 2020 04:04:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4702CAD2C;
        Mon, 24 Aug 2020 08:04:46 +0000 (UTC)
Date:   Mon, 24 Aug 2020 10:04:15 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Himanshu Madhani <himanshu.madhani@oracle.com>
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [PATCH v2 10/11] Revert "scsi: qla2xxx: Fix crash on
 qla2x00_mailbox_command"
Message-ID: <20200824080415.st3hazliqcfwxa4q@beryllium.lan>
References: <20200806111014.28434-1-njavali@marvell.com>
 <20200806111014.28434-11-njavali@marvell.com>
 <20200807075428.bzrhqwllvt5ajfhl@beryllium.lan>
 <DM6PR18MB303407CDC145F69390C28F5AD2440@DM6PR18MB3034.namprd18.prod.outlook.com>
 <8A1A2F11-3BC8-485A-9893-F91AE63DD4ED@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A1A2F11-3BC8-485A-9893-F91AE63DD4ED@oracle.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Saurav,

Sorry for the late response, was on holiday.

> On Aug 10, 2020, at 4:55 AM, Saurav Kashyap <skashyap@marvell.com> wrote:
> This patch was never there in OOT driver, and we never hit an original problem. I have tested this patch myself
> and this have gone through test cycles as well. If an original issue is hit again, we will do an analysis and provide
> the fix. This revert fixes a load issues with ISP82XX.

Ok. Maybe this info could be added to the commit message (next time).

Thanks,
Daniel



