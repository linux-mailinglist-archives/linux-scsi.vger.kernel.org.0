Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C98566189
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Jul 2022 04:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiGECyO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Jul 2022 22:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiGECyB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Jul 2022 22:54:01 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B90810C1
        for <linux-scsi@vger.kernel.org>; Mon,  4 Jul 2022 19:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656989637; x=1688525637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OW/qtsP/DKcWczrLsPxVu/rCogElMQd2wxJH19rxOR0=;
  b=BYpUanOqwEgKit2fuRX55oXT/jozLvkmTJ+x02/8m+GExuiqMHXZlL83
   2JpQE02ksMkeqfBXQsHKG86JdOj13akRC4Q37ykzV4bHI6KLF+h1zfxGq
   l7MbyocUENGEJnir9Eux8M5go0IpyDG/Q9Ma302YFA49Js0F/aui6AZvq
   axP5J1SmRU2ir726i6mbGdP0x3CHVttg1IEj/bAoHZNj1DIBewZNU/Roc
   yqPlyPBexssnb6uSzokX3T7zn6jMTfkLe0Muht43CN77QCzNUEfsqE1Rg
   nTdkW72KYuwKEuP5yxQ0MNsDLIDNZC7PIgMk3rcXP1fhicj6qjaKr6xPH
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="209701204"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:53:56 +0800
IronPort-SDR: OI0r3riDjMCq1NO8SN+M1SIgWLI/eNWjOQvzV/+syf4QJ2SuTBEvjywYXhN7MxI7ImbT5xeJHr
 NgEiwK84VC7yLBsNiDOsJd+PZnULkhcvoP9Wr1hHDEKrrui4GmrAZo+FI0mDFxTtcilwxGR6V7
 UdCHJSql2Ccdm757AhhHtVo6zZkjjUl9gL5KBcT51g34NvMJR4diX/YcbxTEEqkqmAMOBKEimc
 sYpHqMCLmSdyh1NcJVOtSHlaMThMrj6BJVdocz4A/chsuoZunQD2tZCtDoHvLitRdlAsDvoFnt
 VpAulvJ9UisO2ASgah1ro24X
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:11:16 -0700
IronPort-SDR: ZuNk0hFByI/rfQrBJwu4WHx1n4NKdRQfL6ulHrW9zw+DnC4eAiHSAtgfKRGwXgNBOhp6GS4sXt
 vBm3pP0hv7Sb+1KUVNJc0/BPqiUzmy6A0fnwtWp8UpLs8P0qZOn5lh4UB4+bk1AsbxnVprOuqz
 JX3Ias+IL6aL7/3w72KjywfUzviKfBxXW+aCRdwxKz1wi6wcKltPAjZFVf49Bp3UUVmUxmGsB1
 BQ29zMDNdLDKnUMJau+Pdm2utL9hc2rUQEIy+2+of7Q6L/6zJ45HkKvt3sU7Q7z2v8WhrHl2RP
 pms=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:53:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcS1J378Xz1RwqM
        for <linux-scsi@vger.kernel.org>; Mon,  4 Jul 2022 19:53:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656989635; x=1659581636; bh=OW/qtsP/DKcWczrLsPxVu/rCogElMQd2wxJ
        H19rxOR0=; b=bAcQ6cT0fqMHf14S+fDWJVZ4BCgbAmgUmGHqGc4ltbtnXbTQjfn
        PeSVhZ6VUJ8WWJ4N/3yyo9rCVBKVUdb7D//kuEwZb5ZWVjgpNtnUHQMyw1pjukEV
        rgpnr22GNC39A8uv4ftUOl+CWks0r8+sN9SUd8izEMkOFzJdQZG02ORh5gnwiKaC
        AzOYjjlY72lcmzD0SEGtjBIhtevijY9h6TlGz3Vnpa5JkPNXFFIndDMvklzqq9hW
        LV+xyY1OLk3eZLJCKw61y8EbDkHqcWujWw8xg78hKMst5ZhPi10jSHYD6X0uv7ic
        Jjsy797Zo7yxDRDOoN8oRMgT3IJBLN1Va2g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QxNwzbTCoOXa for <linux-scsi@vger.kernel.org>;
        Mon,  4 Jul 2022 19:53:55 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcS1G2BYxz1RtVk;
        Mon,  4 Jul 2022 19:53:54 -0700 (PDT)
Message-ID: <0388d3ac-2339-7c27-aac6-3cf192a9bf08@opensource.wdc.com>
Date:   Tue, 5 Jul 2022 11:53:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 13/17] block: replace blkdev_nr_zones with bdev_nr_zones
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-14-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/4/22 21:44, Christoph Hellwig wrote:
> Pass a block_device instead of a request_queue a that is what most

s/a that/as that

> callers have at hand.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-zoned.c              | 15 ++++++++-------
>  block/ioctl.c                  |  2 +-
>  drivers/block/null_blk/zoned.c |  2 +-
>  drivers/md/dm-zone.c           |  2 +-
>  drivers/md/dm-zoned-target.c   |  5 ++---
>  drivers/nvme/target/zns.c      |  4 ++--
>  fs/zonefs/super.c              | 17 ++++++++---------
>  include/linux/blkdev.h         |  4 ++--
>  8 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 9085f9fb3ab42..836b96ebfdc04 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -108,21 +108,22 @@ void __blk_req_zone_write_unlock(struct request *rq)
>  EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>  
>  /**
> - * blkdev_nr_zones - Get number of zones
> - * @disk:	Target gendisk
> + * bdev_nr_zones - Get number of zones
> + * @bdev:	Target device
>   *
>   * Return the total number of zones of a zoned block device.  For a block
>   * device without zone capabilities, the number of zones is always 0.
>   */
> -unsigned int blkdev_nr_zones(struct gendisk *disk)
> +unsigned int bdev_nr_zones(struct block_device *bdev)
>  {
> -	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
> +	sector_t zone_sectors = bdev_zone_sectors(bdev);
>  
> -	if (!blk_queue_is_zoned(disk->queue))
> +	if (!blk_queue_is_zoned(bdev_get_queue(bdev)))

bdev_is_zoned() ?

>  		return 0;
> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
> +	return (bdev_nr_sectors(bdev) + zone_sectors - 1) >>
> +		ilog2(zone_sectors);
>  }
> -EXPORT_SYMBOL_GPL(blkdev_nr_zones);
> +EXPORT_SYMBOL_GPL(bdev_nr_zones);
>  
>  /**
>   * blkdev_report_zones - Get zones information
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 46949f1b0dba5..60121e89052bc 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -495,7 +495,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>  	case BLKGETZONESZ:
>  		return put_uint(argp, bdev_zone_sectors(bdev));
>  	case BLKGETNRZONES:
> -		return put_uint(argp, blkdev_nr_zones(bdev->bd_disk));
> +		return put_uint(argp, bdev_nr_zones(bdev));
>  	case BLKROGET:
>  		return put_int(argp, bdev_read_only(bdev) != 0);
>  	case BLKSSZGET: /* get block device logical block size */
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 576ab3ed082a5..e62c52e964259 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -170,7 +170,7 @@ int null_register_zoned_dev(struct nullb *nullb)
>  			return ret;
>  	} else {
>  		blk_queue_chunk_sectors(q, dev->zone_size_sects);
> -		q->nr_zones = blkdev_nr_zones(nullb->disk);
> +		q->nr_zones = bdev_nr_zones(nullb->disk->part0);
>  	}
>  
>  	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index ae616b87c91ae..6d105abe12415 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -301,7 +301,7 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
>  	 * correct value to be exposed in sysfs queue/nr_zones.
>  	 */
>  	WARN_ON_ONCE(queue_is_mq(q));
> -	q->nr_zones = blkdev_nr_zones(md->disk);
> +	q->nr_zones = bdev_nr_zones(md->disk->part0);
>  
>  	/* Check if zone append is natively supported */
>  	if (dm_table_supports_zone_append(t)) {
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> index 0ec5d8b9b1a4e..6ba6ef44b00e2 100644
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -793,8 +793,7 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  			}
>  			zone_nr_sectors = blk_queue_zone_sectors(q);
>  			zoned_dev->zone_nr_sectors = zone_nr_sectors;
> -			zoned_dev->nr_zones =
> -				blkdev_nr_zones(zoned_dev->bdev->bd_disk);
> +			zoned_dev->nr_zones = bdev_nr_zones(zoned_dev->bdev);
>  		}
>  	} else {
>  		reg_dev = NULL;
> @@ -805,7 +804,7 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  		}
>  		q = bdev_get_queue(zoned_dev->bdev);
>  		zoned_dev->zone_nr_sectors = blk_queue_zone_sectors(q);
> -		zoned_dev->nr_zones = blkdev_nr_zones(zoned_dev->bdev->bd_disk);
> +		zoned_dev->nr_zones = bdev_nr_zones(zoned_dev->bdev);
>  	}
>  
>  	if (reg_dev) {
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index c6f0a775efdee..c9b2ce06ca93e 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -60,7 +60,7 @@ bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
>  	if (ns->bdev->bd_disk->queue->conv_zones_bitmap)
>  		return false;
>  
> -	ret = blkdev_report_zones(ns->bdev, 0, blkdev_nr_zones(bd_disk),
> +	ret = blkdev_report_zones(ns->bdev, 0, bdev_nr_zones(ns->bdev),
>  				  validate_conv_zones_cb, NULL);
>  	if (ret < 0)
>  		return false;
> @@ -241,7 +241,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
>  {
>  	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>  
> -	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
> +	return bdev_nr_zones(req->ns->bdev) -
>  		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
>  }
>  
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 053299758deb9..9c0eef1ff32a0 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1394,7 +1394,7 @@ static void zonefs_init_dir_inode(struct inode *parent, struct inode *inode,
>  {
>  	struct super_block *sb = parent->i_sb;
>  
> -	inode->i_ino = blkdev_nr_zones(sb->s_bdev->bd_disk) + type + 1;
> +	inode->i_ino = bdev_nr_zones(sb->s_bdev) + type + 1;
>  	inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
>  	inode->i_op = &zonefs_dir_inode_operations;
>  	inode->i_fop = &simple_dir_operations;
> @@ -1540,7 +1540,7 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
>  	/*
>  	 * The first zone contains the super block: skip it.
>  	 */
> -	end = zd->zones + blkdev_nr_zones(sb->s_bdev->bd_disk);
> +	end = zd->zones + bdev_nr_zones(sb->s_bdev);
>  	for (zone = &zd->zones[1]; zone < end; zone = next) {
>  
>  		next = zone + 1;
> @@ -1635,8 +1635,8 @@ static int zonefs_get_zone_info(struct zonefs_zone_data *zd)
>  	struct block_device *bdev = zd->sb->s_bdev;
>  	int ret;
>  
> -	zd->zones = kvcalloc(blkdev_nr_zones(bdev->bd_disk),
> -			     sizeof(struct blk_zone), GFP_KERNEL);
> +	zd->zones = kvcalloc(bdev_nr_zones(bdev), sizeof(struct blk_zone),
> +			     GFP_KERNEL);
>  	if (!zd->zones)
>  		return -ENOMEM;
>  
> @@ -1648,9 +1648,9 @@ static int zonefs_get_zone_info(struct zonefs_zone_data *zd)
>  		return ret;
>  	}
>  
> -	if (ret != blkdev_nr_zones(bdev->bd_disk)) {
> +	if (ret != bdev_nr_zones(bdev)) {
>  		zonefs_err(zd->sb, "Invalid zone report (%d/%u zones)\n",
> -			   ret, blkdev_nr_zones(bdev->bd_disk));
> +			   ret, bdev_nr_zones(bdev));
>  		return -EIO;
>  	}
>  
> @@ -1816,8 +1816,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	if (ret)
>  		goto cleanup;
>  
> -	zonefs_info(sb, "Mounting %u zones",
> -		    blkdev_nr_zones(sb->s_bdev->bd_disk));
> +	zonefs_info(sb, "Mounting %u zones", bdev_nr_zones(sb->s_bdev));
>  
>  	if (!sbi->s_max_wro_seq_files &&
>  	    !sbi->s_max_active_seq_files &&
> @@ -1833,7 +1832,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	if (!inode)
>  		goto cleanup;
>  
> -	inode->i_ino = blkdev_nr_zones(sb->s_bdev->bd_disk);
> +	inode->i_ino = bdev_nr_zones(sb->s_bdev);
>  	inode->i_mode = S_IFDIR | 0555;
>  	inode->i_ctime = inode->i_mtime = inode->i_atime = current_time(inode);
>  	inode->i_op = &zonefs_dir_inode_operations;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index e32c147f72868..183aa83143fd2 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -298,7 +298,7 @@ void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
>  #define BLK_ALL_ZONES  ((unsigned int)-1)
>  int blkdev_report_zones(struct block_device *bdev, sector_t sector,
>  			unsigned int nr_zones, report_zones_cb cb, void *data);
> -unsigned int blkdev_nr_zones(struct gendisk *disk);
> +unsigned int bdev_nr_zones(struct block_device *bdev);
>  extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>  			    sector_t sectors, sector_t nr_sectors,
>  			    gfp_t gfp_mask);
> @@ -314,7 +314,7 @@ extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>  
>  #else /* CONFIG_BLK_DEV_ZONED */
>  
> -static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
> +static inline unsigned int bdev_nr_zones(struct block_device *bdev)
>  {
>  	return 0;
>  }


-- 
Damien Le Moal
Western Digital Research
