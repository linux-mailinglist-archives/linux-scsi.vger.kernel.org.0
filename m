Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049E750FA3
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfFXPGG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 11:06:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47994 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFXPGG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 11:06:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OEx6G4058419;
        Mon, 24 Jun 2019 15:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=qRyv4vTqhChdLXGzwrJYn2gmkvZo8zWFWGFIEX73sCY=;
 b=wO59i3iyCSdSx9/JAYA5AlYQ5J7azt2TiFhkzJmC7JJ8VG+hEXebYPZXfyDCEnlCtC/k
 0aTNclSzVXd3z5JaS6uDzUlkvg9um64Z+/QGQEFLr3Z16EEese+qFdctQqSBuCEEjO1u
 fyvQfG4ifCNnGS3h7ZhlZBbe0gMqa9NDQvoIkOKfIyoMKw+T/A8Lm38DPunpPp4TbD3m
 b38X/2Acw3ffmbmw2yLJ50yeN84pnTEC+YO0q79DGPCWTAcWNWjCzRKAvOpM3JoeY07V
 f4W3gAPcUsyNDC1aZemU8ZfSZqUIpjQByu/H2GTvvu9fp9t9vqwY5LsCaFuSzhBTSvEz 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t9cyq6xd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 15:06:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OF4g7L065369;
        Mon, 24 Jun 2019 15:05:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9p6tmvq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 15:05:59 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OF5tWF030993;
        Mon, 24 Jun 2019 15:05:56 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 08:05:53 -0700
Date:   Mon, 24 Jun 2019 18:05:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     bgrove@attotech.com
Cc:     linux-scsi@vger.kernel.org
Subject: [bug report] [SCSI] esas2r: Directly call kernel functions for
 atomic bit operations
Message-ID: <20190624150538.GA18737@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=791
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=833 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240122
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

[ Ancient code, but the fix should be obvious if anyone wanted to test
  it.  - dan ]

Hello Bradley Grove,

The patch 9588d24e3600: "[SCSI] esas2r: Directly call kernel
functions for atomic bit operations" from Oct 1, 2013, leads to the
following static checker warning:

	drivers/scsi/esas2r/esas2r_init.c:858 esas2r_init_adapter_struct()
	warn: 'AF2_SERIAL_FLASH' is a shifter (not for '|=').

drivers/scsi/esas2r/esas2r_init.c
   849          /*
   850           * the thunder_stream boards all have a serial flash part that has a
   851           * different base address on the AHB bus.
   852           */
   853          if ((a->pcid->subsystem_vendor == ATTO_VENDOR_ID)
   854              && (a->pcid->subsystem_device & ATTO_SSDID_TBT))
   855                  a->flags2 |= AF2_THUNDERBOLT;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This should be "a->flags2 |= BIT(AF2_THUNDERBOLT)" or
set_bit(AF2_THUNDERBOLT, &&a->flags2);

   856  
   857          if (test_bit(AF2_THUNDERBOLT, &a->flags2))
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
So that it matches this line.

   858                  a->flags2 |= AF2_SERIAL_FLASH;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   859  
   860          if (a->pcid->subsystem_device == ATTO_TLSH_1068)
   861                  a->flags2 |= AF2_THUNDERLINK;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Same for these.  But the code is really old and no one has noticed the
bug...

   862  
   863          /* Uncached Area */
   864          high = (u8 *)*uncached_area;
   865  

regards,
dan carpenter
