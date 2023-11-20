Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B367F0CE6
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Nov 2023 08:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjKTHhM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Nov 2023 02:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTHhK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 Nov 2023 02:37:10 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AA9B7
        for <linux-scsi@vger.kernel.org>; Sun, 19 Nov 2023 23:37:05 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231120073703epoutp0235e7e27a39fbd9747f04da2643530201~ZRKg6y7YB2905529055epoutp023
        for <linux-scsi@vger.kernel.org>; Mon, 20 Nov 2023 07:37:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231120073703epoutp0235e7e27a39fbd9747f04da2643530201~ZRKg6y7YB2905529055epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700465823;
        bh=kf6A6gxsjK4BnYZeEdWs1d41PoIm5/kxJrnoBK73RyU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Vl6AE+JpcI+RF+D2M3O7GolQhGXfwFcDGaP9UobE8QRU5pZgRkZCyXe6uWFXn8FT7
         Iks0LKuKfUIwGaGVdGKtDgDPluDAh54JRMy3OtfK6PzU3kmRHm8nwQRSXBIEj7z1pm
         WVBP1Ygtg9BuekmSOeo9H3SDYv63UO9AO7CJSH4c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231120073703epcas5p2f64a5e0dd7f3605a0bb265352de0e358~ZRKggHp_m1114011140epcas5p2B;
        Mon, 20 Nov 2023 07:37:03 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SYfTn2Y4Tz4x9Q5; Mon, 20 Nov
        2023 07:37:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.98.19369.B9C0B556; Mon, 20 Nov 2023 16:36:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231120073659epcas5p169986d215d40a3cbe1620cb3b192629e~ZRKdJcyBF1056810568epcas5p1z;
        Mon, 20 Nov 2023 07:36:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120073659epsmtrp2a03ee795da059d1fb74f46e08b1100d4~ZRKdIYR-52627226272epsmtrp25;
        Mon, 20 Nov 2023 07:36:59 +0000 (GMT)
X-AuditID: b6c32a50-2ae3ca8000004ba9-36-655b0c9b7315
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.54.08817.B9C0B556; Mon, 20 Nov 2023 16:36:59 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231120073657epsmtip1a4e36c86d071fecbf4818d69dfe19384~ZRKbP3OS93017030170epsmtip1N;
        Mon, 20 Nov 2023 07:36:57 +0000 (GMT)
Message-ID: <da181fff-59af-b9fd-dd18-781b5ec13cd7@samsung.com>
Date:   Mon, 20 Nov 2023 13:06:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4 05/15] fs/f2fs: Restore data lifetime support
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Daejun Park <daejun7.park@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>, Chao Yu <chao@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231114214132.1486867-6-bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmpu5snuhUg9dLLCxe/rzKZrH6bj+b
        xbQPP5ktTk89y2Tx5EA7o8WqB+EWK1cfBfLWz2K22HtL22LP3pMsFt3Xd7BZLD/+j8mBx+Py
        FW+Py2dLPTat6mTz2H2zgc1jcd9kVo+PT2+xePRtWcXo8XmTnEf7gW6mAM6obJuM1MSU1CKF
        1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoHuVFMoSc0qBQgGJxcVK
        +nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZHc8b2AueMlZM
        njyTrYFxG2MXIyeHhICJxJmZ91hAbCGBPYwSD3tlIexPjBIfblZ2MXIB2d8YJQ5+WMYG03C+
        5yUzRGIvo8StT8dZIZy3jBL3LsxiAqniFbCTeHdwH9gKFgFViQ/7XkLFBSVOznwCtk5UIEni
        19U5QDUcHMICLhK79xuDhJkFxCVuPZkPVi4iECfROusVI8h8ZoFTTBK3JmwDq2cT0JS4MLkU
        xOQUsJJ4+EMColVeYvvbOWC3SQic4JBYdvcd1NEuEm/fHGKCsIUlXh3fwg5hS0l8frcXqiZZ
        4tLMc1A1JRKP9xyEsu0lWk/1M4PsYgZau36XPsQuPone30+YQMISArwSHW1CENWKEvcmPWWF
        sMUlHs5YAmV7SJw42McID7ZTP5axTWBUmIUUKLOQfD8LyTuzEDYvYGRZxSiVWlCcm56abFpg
        qJuXWg6P7uT83E2M4MSsFbCDcfWGv3qHGJk4GA8xSnAwK4nwfhOKSBXiTUmsrEotyo8vKs1J
        LT7EaAqMnonMUqLJ+cDckFcSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8T
        B6dUA5Nk5O/j2Ycajs6t/B9yLU00erZB+9fpE18eUpX+u7I7XENg6bmqNNFu3nqDN9IBL38F
        SfL8LSltPvZQdNXdrI3Fjku75FzabYyO/Xy71+LQzMUM9vwmjsu+/PzdK3Lhonaim5nY+ju/
        D5VynJr/wf/TMtnfyyL9Ui6xX3iSrnw2+FSuXNKifdMup4r5LzQL+vpG2olZIlahktmRwTL0
        aFDeatN9uzr21dyzFP6wV2qn+y/zfQ/kjk1KMKt/bRmR6KdltGqVE0MpyxyOZKOJr+UfL61Z
        GV+/Wuthtobcj5c1PVmTdISsAhSuckwXvtrfN/tz5cXEMIur6+v+t4fPEb9+znfhojOXNmR8
        CMlimqnEUpyRaKjFXFScCADcKTKXVQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnO5snuhUg3nPZCxe/rzKZrH6bj+b
        xbQPP5ktTk89y2Tx5EA7o8WqB+EWK1cfBfLWz2K22HtL22LP3pMsFt3Xd7BZLD/+j8mBx+Py
        FW+Py2dLPTat6mTz2H2zgc1jcd9kVo+PT2+xePRtWcXo8XmTnEf7gW6mAM4oLpuU1JzMstQi
        fbsEroyO5w3sBU8ZKyZPnsnWwLiNsYuRk0NCwETifM9L5i5GLg4hgd2MErefvWeHSIhLNF/7
        AWULS6z895wdoug1o8SyDy/ZQBK8AnYS7w7uA5vEIqAq8WHfSyaIuKDEyZlPWEBsUYEkiT33
        G4HiHBzCAi4Su/cbg4SZgebfejIfrFxEIE7i8P4bYPOZBU4xScy6NZUVYtleRonlxx6zgzSz
        CWhKXJhcCmJyClhJPPwhATHHTKJraxcjhC0vsf3tHOYJjEKzkFwxC8m6WUhaZiFpWcDIsopR
        MrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgOtbR2MO5Z9UHvECMTB+MhRgkOZiUR3m9C
        EalCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1MK1v6vM/
        7+TocO7D6uRs/74PjKdW/9kcx39k9ocn/V3bjO4b5sm29WkGqdtkPXGIYf74c/2Jh/WvGKSD
        mNhV2m8VvC3e4bf0tGzolef327ONn01nuyDz5tlRZa9Ek++3G7xd3EsfZ2QnS5x9ZLzJz61A
        UkJLRvWemyBnge2aD0d+ZPks/+PxT+y6dUtwUMjdy48UNDrZtmju/jpNUG1WTN3+7QtcvuWs
        eXvDXvrGrEc7PS+GP5pUHHFi39raBb6RnzZz8Sv+Vmp5abQ7f8HJfT5TxC6fv73l3B6HRF67
        2g8C+qsMngd1PY56rKQs+nhXftIM9k1Hb1nFO4bXrk3jvna22Oxb31+eK6JFByM3+imxFGck
        GmoxFxUnAgDYMigaMgMAAA==
X-CMS-MailID: 20231120073659epcas5p169986d215d40a3cbe1620cb3b192629e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231114214215epcas5p43476e8ccba9bfccc87dac59bcb5a5e62
References: <20231114214132.1486867-1-bvanassche@acm.org>
        <CGME20231114214215epcas5p43476e8ccba9bfccc87dac59bcb5a5e62@epcas5p4.samsung.com>
        <20231114214132.1486867-6-bvanassche@acm.org>
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/15/2023 3:11 AM, Bart Van Assche wrote:
> +2) whint_mode=user-based. F2FS tries to pass down hints given by
> +users.

It does not pass down fcntl/inode based hints.
So I wonder how users give the hints in this case?
