Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A165FDCB4
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Oct 2022 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJMO4t (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Oct 2022 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJMO4r (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 13 Oct 2022 10:56:47 -0400
X-Greylist: delayed 432 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Oct 2022 07:56:45 PDT
Received: from smtp96.iad3b.emailsrvr.com (smtp96.iad3b.emailsrvr.com [146.20.161.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F52B106926
        for <linux-scsi@vger.kernel.org>; Thu, 13 Oct 2022 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=highpoint-tech.com;
        s=20220804-ejv8r95b; t=1665672573;
        bh=tIBZTIhsrv/I2APWljX116nGU0m5Ld7k7bwNw9Daxxo=;
        h=From:To:Subject:Date:From;
        b=i9d3RyFf+uijZIZ1W3FQ1p/8tq5N3QuYx22VkZ2arecrezCOuo63+vxppJ3ltccec
         kY+5E8q6VDqfLYIU/JtUGGb3w/RjTWKpPkKJTdRuZV5kkCDBwK093QsR6+co1o8ITd
         YbkafTMGldamVKZGrRrgPgucvFa/frP/22y0N1yo=
X-Auth-ID: linux@highpoint-tech.com
Received: by smtp13.relay.iad3b.emailsrvr.com (Authenticated sender: linux-AT-highpoint-tech.com) with ESMTPSA id 335BA60141;
        Thu, 13 Oct 2022 10:49:31 -0400 (EDT)
From:   <linux@highpoint-tech.com>
To:     <jejb@linux.ibm.com>
Cc:     <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Update mvsas source code to support Marvell SAS 12Gb/s chipset(88SE1485/88SE1495/88SE1475)
Date:   Thu, 13 Oct 2022 22:49:29 +0800
Message-ID: <00b101d8df13$01e001a0$05a004e0$@highpoint-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdjfEvbPZIngYzXZTCaXGzaEW1zoQQ==
Content-Language: en-us
X-Classification-ID: 55086429-d49c-4028-b889-1019efb1ef67-1-1
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

      This is HighPoint (https://www.highpoint-tech.com). It is a pleasure
to contact you.
   
      We are planning to update mvsas source code to support Marvell SAS
12Gb/s chipset(88SE1485/88SE1495/88SE1475).
  
      Due to the relatively long development cycle, we would like to check
with you in advance if this update is allowed?

      Looking forward to your reply. Thank you.

Best Regards,
HighPoint Linux Team.



